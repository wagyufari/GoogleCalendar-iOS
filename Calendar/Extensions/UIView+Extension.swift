//
//  UIView+Extension.swift
//  Calendar
//
//  Created by Muhammad Ghifari on 1/5/2023.
//

import Foundation
import UIKit

extension UIView {
    func removeAllSubviews() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }
}
