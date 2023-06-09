//
//  CalendarPageView.swift
//  Calendar
//
//  Created by Muhammad Ghifari on 1/5/2023.
//

import Foundation
import UIKit

class MainView: UIView{
    
    var date: Date? {
        didSet{
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    var collectionView: UICollectionView!
    let collectionViewLayout: UICollectionViewFlowLayout
    var eventContainer: UIView
    
    let dateLabel = UILabel()
    
    init(){
        collectionViewLayout = UICollectionViewFlowLayout()
        eventContainer = UIView()
        super.init(frame: .zero)
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: collectionViewLayout)
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.minimumLineSpacing = 0
        eventContainer.isUserInteractionEnabled = false
        backgroundColor = .white
        addSubview(collectionView)
        addSubview(eventContainer)
        addSubview(dateLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        performContent()
        performLayout()
        collectionView.backgroundColor = .white
    }
    
    func performContent() {
        if let date {
            let calendar = Calendar.current
            let month = calendar.component(.month, from: date)
            let year = calendar.component(.year, from: date)
            dateLabel.text = "\(month) \(year)"
            dateLabel.textColor = .black
            dateLabel.font = .systemFont(ofSize: 32)
        }
    }
    
    func performLayout() {
        collectionView.pin.all(pin.safeArea)
        eventContainer.pin.all(pin.safeArea)
        dateLabel.pin.center().sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MainView {
    
    func createGridLinesView() -> UIView {
        let view = UIView(frame: collectionView.frame)
        view.backgroundColor = .clear
        
        // Add vertical lines
        for i in 1..<7 {
            let x = CGFloat(i) * collectionView.frame.width / 7
            let line = UIView(frame: CGRect(x: x, y: 0, width: 1, height: bounds.height - pin.safeArea.top))
            line.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            view.addSubview(line)
        }
        
        // Add horizontal lines
        for i in 1..<6 {
            let y = CGFloat(i) * (collectionView.frame.height / 6)
            let line = UIView(frame: CGRect(x: 0, y: y, width: collectionView.frame.width, height: 1))
            line.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            view.addSubview(line)
        }
        
        return view
    }
    
}
