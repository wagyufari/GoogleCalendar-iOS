//
//  EventCell.swift
//  Calendar
//
//  Created by Muhammad Ghifari on 3/5/2023.
//

import Foundation
import UIKit

class EventCell: UIView{
    
    let labelDescription: UILabel
    
    let eventName: String
    let eventType: EventType
    
    var leadingCoordinate: CGPoint {
        didSet{
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    var trailingCoordinate: CGPoint
    let index: Int
    
    init(eventName: String, eventType: EventType, leadingCoordinate: CGPoint, trailingCoordinate: CGPoint, index: Int){
        self.eventName = eventName
        self.eventType = eventType
        self.index = index
        self.leadingCoordinate = leadingCoordinate
        self.trailingCoordinate = trailingCoordinate
        labelDescription = UILabel()
        super.init(frame: .zero)
        addSubview(labelDescription)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        performContent()
        performLayout()
    }
    
    func performContent() {
        labelDescription.font = .systemFont(ofSize: 10, weight: .medium)
        labelDescription.text = eventName
        layer.cornerRadius = 4
        
        switch eventType {
        case .Scheduled:
            labelDescription.textColor = UIColor(hexString: "#1B89E1")
            layer.borderColor = UIColor(hexString: "#1B89E1").cgColor
            layer.borderWidth = 1.1
            backgroundColor = .white
        case .Recurring:
            labelDescription.textColor = .white
            backgroundColor = UIColor(hexString: "#1B89E1")
        case .Holiday:
            labelDescription.textColor = .white
            backgroundColor = UIColor(hexString: "#3F8A7D")
        }
    }
    
    func performLayout() {
        guard let superView = superview else { return }
        let xPosition = leadingCoordinate.x
        let yPosition = leadingCoordinate.y + superView.pin.safeArea.top + 32 + CGFloat(index * 18)
        let width = (trailingCoordinate.x - leadingCoordinate.x - 4) + superView.bounds.width / 7
        let height: CGFloat = 16
        pin.width(width).height(height).top(yPosition).left(xPosition)
        labelDescription.pin.horizontally(4).vertically()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
