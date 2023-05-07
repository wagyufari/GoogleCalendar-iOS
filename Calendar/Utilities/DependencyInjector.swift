//
//  DependencyInjector.swift
//  Calendar
//
//  Created by Muhammad Ghifari on 3/5/2023.
//

import Foundation
import Swinject
import UIKit

func resolveContainer() -> Container {
    let container = Container()
    container.register(GetCalendarByMonthAndYearUseCase.self) { _ in
        GetCalendarByMonthAndYearUseCase()
    }
    container.register(GetEventsUseCase.self) { _ in
        GetEventsUseCase()
    }
    return container
}

func sl<T>() -> T {
    return (UIApplication.shared.delegate as! AppDelegate).container.resolve(T.self)!
}

