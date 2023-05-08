//
//  MainViewController.swift
//  Calendar
//
//  Created by Muhammad Ghifari on 8/5/2023.
//

import Foundation
import UIKit
import PinLayout

class MainViewController: UIPageViewController {
    var dates: [Date] = [Date()]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        
        let yearsToGoBack = 10
        let yearsToGoForward = 10

        var dateComponents = DateComponents()
        dateComponents.month = 1

        for _ in 1...yearsToGoBack*12 {
            let newDate = Calendar.current.date(byAdding: dateComponents, to: dates.last!)!
            dates.append(newDate)
        }
        dateComponents.month = -1
        for _ in 1...yearsToGoForward*12 {
            let newDate = Calendar.current.date(byAdding: dateComponents, to: dates.first!)!
            dates.insert(newDate, at: 0)
        }

        if let currentMonthIndex = dates.firstIndex(where: { Calendar.current.isDate($0, equalTo: Date(), toGranularity: .month) }), let firstViewController = viewController(at: currentMonthIndex) {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    func viewController(at index: Int) -> CalendarPageViewController? {
        guard index >= 0 && index < dates.count else {
            return nil
        }

        let calendarPageViewController = CalendarPageViewController()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        calendarPageViewController.date = dates[index]
        calendarPageViewController.getDates()

        return calendarPageViewController
    }
}


extension MainViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore controller: UIViewController) -> UIViewController? {
        guard let currentViewController = controller as? CalendarPageViewController, let date = currentViewController.date,
            let currentIndex = dates.firstIndex(of: date) else {
                return nil
        }

        let previousIndex = (currentIndex == 0) ? dates.count - 1 : currentIndex - 1
        return viewController(at: previousIndex)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter controller: UIViewController) -> UIViewController? {
        guard let currentViewController = controller as? CalendarPageViewController, let date = currentViewController.date,
            let currentIndex = dates.firstIndex(of: date) else {
                return nil
        }

        let nextIndex = (currentIndex == dates.count - 1) ? 0 : currentIndex + 1
        return viewController(at: nextIndex)
    }
}
