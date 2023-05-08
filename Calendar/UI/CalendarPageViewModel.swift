//
//  CalendarPageViewModel.swift
//  Calendar
//
//  Created by Muhammad Ghifari on 1/5/2023.
//

import Foundation
import RxSwift
import RxRelay

class MainViewModel {
    
    let dates: BehaviorRelay<[Date]> = BehaviorRelay(value: [])
    let events: BehaviorRelay<[(String, EventType, [Date])]> = BehaviorRelay(value: [])
    
    let getCalendarByMonthAndYearUseCase: GetCalendarByMonthAndYearUseCase
    let getEventsUseCase: GetEventsUseCase
    
    init(getCalendarByMonthAndYearUseCase: GetCalendarByMonthAndYearUseCase, getEventsUseCase: GetEventsUseCase) {
        self.getCalendarByMonthAndYearUseCase = getCalendarByMonthAndYearUseCase
        self.getEventsUseCase = getEventsUseCase
    }
    
    func getDates(date: Date?) {
        if let date {
            let calendar = Calendar.current
            let month = calendar.component(.month, from: date)
            let year = calendar.component(.year, from: date)
            dates.accept(getCalendarByMonthAndYearUseCase.invoke(month: month, year: year))
            events.accept(getEventsUseCase.invoke())
        }
    }
    
}
