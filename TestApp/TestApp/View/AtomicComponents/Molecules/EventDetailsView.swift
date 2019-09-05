//
//  EventDetailsView.swift
//  TestApp
//
//  Created by Anthony Smith on 05/09/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

class EventDetailsView: UIView {
    
    init() {
        super.init(frame: .zero)
        addSubview(scheduleLabel)
        addSubview(priceLabel)
        
        priceLabel.pin(to: self, [.trailing(-.keyline), .top(.small)])
        scheduleLabel.pin(to: self, [.leading(.keyline), .top(.small), .bottom(-.small)])
        scheduleLabel.pin(to: priceLabel, [.leftOf(-.small)])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(scheduleString: String, priceString: String) {
        scheduleLabel.text = "When:\n\(scheduleString)"
        priceLabel.text = priceString
    }
    
    // MARK: - Properties
    
    private lazy var scheduleLabel: Label = {
        let label = Label()
        label.apply(typography: .medium, color: .text(.secondary))
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var priceLabel: Label = {
        let label = Label()
        label.apply(typography: .xxlarge(.strong), color: .text)
        return label
    }()
}
