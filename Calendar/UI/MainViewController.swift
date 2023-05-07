//
//  ViewController.swift
//  Calendar
//
//  Created by Muhammad Ghifari on 1/5/2023.
//

import UIKit
import PinLayout
import RxSwift
import RxRelay
import RxCocoa

class MainViewController: UIViewController {
    
    private let parentView = MainView()
    private let viewModel = MainViewModel(getCalendarByMonthAndYearUseCase: sl(), getEventsUseCase: sl())
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = parentView
    }
    
    let data = BehaviorRelay<[String]>(value: [])
    var events: [[String]] = []
    var dateCoordinates: BehaviorRelay<[(Date, CGPoint)]> = BehaviorRelay(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parentView.collectionView.backgroundColor = .white
        parentView.collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "MyCell")
        
        viewModel.dates.bind(to: parentView.collectionView.rx.items(cellIdentifier: "MyCell", cellType: CalendarCell.self)) { index, model, cell in
            cell.configure(date: model, selected: false)
            let cellScreenOrigin = self.parentView.convert(cell.frame.origin, to: nil)
            self.dateCoordinates.accept(self.dateCoordinates.value + [(model, cellScreenOrigin)])
        }.disposed(by: disposeBag)
        
        self.dateCoordinates.subscribe { _ in
            self.parentView.eventContainer.removeAllSubviews()
            
            var occupiedDates: [(Date, Int)] = []
            
            self.viewModel.events.value.forEach { eventName, eventType, dates in
                var leadingCoordinate: CGPoint?
                var trailingCoordinate: CGPoint?
                
                if let leadingDate = dates[safe: 0] {
                    leadingCoordinate = self.dateCoordinates.value.first { (Date, CGPoint) in
                        Date == leadingDate
                    }?.1
                    trailingCoordinate = leadingCoordinate
                }
                
                if let trailingDate = dates[safe: 1] {
                    trailingCoordinate = self.dateCoordinates.value.first { (Date, CGPoint) in
                        Date == trailingDate
                    }?.1
                }
                
                if let leadingCoordinate, let trailingCoordinate {
                    var index = 0
                    
                    while occupiedDates.contains(where: {
                        dates.contains($0.0) && $0.1 == index
                    }){
                        index += 1
                    }
                    
                    let cell = EventCell(eventName: eventName, eventType: eventType, leadingCoordinate: leadingCoordinate, trailingCoordinate: trailingCoordinate, index: index)
                    
                    var maxIndex = 0
                    let availableEventArea = Int(self.parentView.eventContainer.frame.height / 6 - 32)
                    while 20 * maxIndex < availableEventArea {
                        maxIndex += 1
                    }
                    
                    if index < maxIndex {
                        self.parentView.eventContainer.addSubview(cell)
                        if let endDate = dates[safe: 1], let startDate = dates[safe: 0]{
                            var currentDate = startDate
                            let calendar = Calendar.current
                            while currentDate <= endDate {
                                occupiedDates.append((currentDate, index))
                                currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
                            }
                        } else if let startDate = dates[safe: 0] {
                            occupiedDates.append((startDate, index))
                        }
                    }
                }
            }
            
        }.disposed(by: disposeBag)
        
    }
    
    override func viewDidLayoutSubviews() {
        parentView.collectionViewLayout.itemSize = CGSize(width: parentView.bounds.width / 7, height: parentView.collectionView.frame.height / 6)
        parentView.collectionView.backgroundView = parentView.createGridLinesView()
    }
}

