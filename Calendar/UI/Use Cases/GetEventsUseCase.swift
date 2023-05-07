//
//  GetEventsUseCase.swift
//  Calendar
//
//  Created by Muhammad Ghifari on 3/5/2023.
//

import Foundation

struct GetEventsUseCase {
    
    func invoke() -> [(String, EventType, [Date])] {
        var events: [(String, EventType, [String])] = []
        
        events.append(("Weekly Sync", .Recurring, ["27-03-2023"]))
        events.append(("Weekly Sync", .Recurring, ["03-04-2023"]))
        events.append(("Weekly Sync", .Recurring, ["10-04-2023"]))
        events.append(("Weekly Sync", .Recurring, ["17-04-2023"]))
        events.append(("Weekly Sync", .Recurring, ["24-04-2023"]))
        events.append(("Weekly Sync", .Recurring, ["1-05-2023"]))
        events.append(("Dentist Appointment", .Recurring, ["05-04-2023"]))
        events.append(("Good Friday", .Holiday, ["07-04-2023"]))
        events.append(("Easter Saturday", .Holiday, ["08-04-2023"]))
        events.append(("Easter Sunday", .Holiday, ["09-04-2023"]))
        events.append(("Sprint Meeting", .Scheduled, ["11-04-2023"]))
        events.append(("Urgent Something", .Scheduled, ["12-04-2023"]))
        events.append(("Ahmad on Leave", .Scheduled, ["13-04-2023"]))
        events.append(("Budi on Leave", .Scheduled, ["14-04-2023"]))
        events.append(("Townhall", .Scheduled, ["14-04-2023"]))
        events.append(("Makan-makan", .Scheduled, ["14-04-2023"]))
        events.append(("Eko Cuti Lebaran(Pulang Kampung)", .Scheduled, ["19-04-2023", "28-04-2023"]))
        events.append(("Fahri Cuti Lebaran", .Scheduled, ["20-04-2023", "28-04-2023"]))
        events.append(("Dika Cuti Lebaran", .Scheduled, ["20-04-2023", "28-04-2023"]))
        events.append(("Fajar Eid Leave", .Scheduled, ["21-04-2023", "28-04-2023"]))
        events.append(("Idul Fitri Joint Holiday", .Holiday, ["19-04-2023", "28-04-2023"]))
        events.append(("Product Launch", .Scheduled, ["01-04-2023"]))
        events.append(("Monthly Budget Meeting", .Recurring, ["04-04-2023"]))
        events.append(("Quarterly Business Review", .Scheduled, ["06-04-2023", "07-04-2023"]))
        events.append(("Company Retreat", .Scheduled, ["15-04-2023", "17-04-2023"]))
        events.append(("Earth Day", .Holiday, ["22-04-2023"]))
        events.append(("Client Meeting", .Scheduled, ["25-04-2023"]))

        
        var updatedEvents: [(String, EventType, [Date])] = []
        
        events.forEach { (eventName, eventType, dates) in
            let formattedDates = dates.map { $0.getDateFromSimpleFormat() }
            if let startDate = formattedDates.first, let endDate = formattedDates.last {
                if eventType == .Holiday {
                    var tempStartDate = startDate
                    while tempStartDate <= endDate {
                        updatedEvents.append((eventName, eventType, [tempStartDate]))
                        tempStartDate = tempStartDate.advancedBy(days: 1)
                    }
                } else if isInSameWeek(startDate, endDate) {
                    updatedEvents.append((eventName, eventType, [startDate, endDate]))
                } else {
                    var tempStartDate = startDate
                    while !isInSameWeek(tempStartDate, endDate) {
                        updatedEvents.append((eventName, eventType, [tempStartDate, tempStartDate.endOfWeek()]))
                        tempStartDate = tempStartDate.endOfWeek().advancedBy(days: 1)
                    }
                    updatedEvents.append((eventName, eventType, [tempStartDate, endDate]))
                }
            } else {
                updatedEvents.append((eventName, eventType, formattedDates))
            }
        }
        
        return updatedEvents
    }
    
    func isInSameWeek(_ startDate: Date, _ endDate: Date) -> Bool {
        let calendar = Calendar.current
        let startWeek = calendar.component(.weekOfYear, from: startDate)
        let endWeek = calendar.component(.weekOfYear, from: endDate)
        return startWeek == endWeek
    }
    
}

enum EventType {
    case Scheduled
    case Recurring
    case Holiday
}

extension TimeInterval {
    static let dayTimeInterval: TimeInterval = 24 * 60 * 60
}
