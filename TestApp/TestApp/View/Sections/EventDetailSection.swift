//
//  EventDetailSection.swift
//  TestApp
//
//  Created by Anthony Smith on 05/09/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

extension SectionBuilder {
    public func eventDetails(_ schedule: @autoclosure @escaping () -> String, _ price: @autoclosure @escaping () -> String) -> EventDetailSection {
        return EventDetailSection(scheduleClosure: schedule, priceClosure: price)
    }
}

public class EventDetailSection {
    
    fileprivate let scheduleClosure: () -> String
    fileprivate let priceClosure: () -> String

    public init(scheduleClosure: @escaping () -> String, priceClosure: @escaping () -> String) {
        self.scheduleClosure = scheduleClosure
        self.priceClosure = priceClosure
    }
}

extension EventDetailSection: ViewSection {
    
    public func createView() -> UIView {
        return EventDetailsView()
    }
    
    public func size(in view: UIView, at index: Int) -> SectionCellSize {
        return SectionCellSize(width: view.bounds.size.width, height: nil)
    }
    
    public func configure(_ view: UIView, at index: Int) {
        (view as? EventDetailsView)?.set(scheduleString: scheduleClosure(), priceString: priceClosure())
    }
}
