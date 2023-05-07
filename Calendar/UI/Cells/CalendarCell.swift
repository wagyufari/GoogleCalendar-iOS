//
//  CalendarCell.swift
//  Calendar
//
//  Created by Muhammad Ghifari on 1/5/2023.
//

import Foundation
import PinLayout

class CalendarCell: UICollectionViewCell {
    
    private let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set up the date label
        dateLabel.textAlignment = .center
        contentView.addSubview(dateLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.pin.top(8).sizeToFit().hCenter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(date: Date, selected: Bool) {
        dateLabel.text = date.dayOfMonth().description
        dateLabel.textColor = selected ? .white : .black
        dateLabel.backgroundColor = selected ? .blue : .clear
    }
    
}
