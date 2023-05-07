//
//  MainViewModel.swift
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
        let now = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: now)
        let year = calendar.component(.year, from: now)
        dates.accept(getCalendarByMonthAndYearUseCase.invoke(month: 4, year: 2023))
        events.accept(getEventsUseCase.invoke())
    }
    
}
