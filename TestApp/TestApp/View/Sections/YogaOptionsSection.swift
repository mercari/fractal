//
//  YogaOptionsSection.swift
//  TestApp
//
//  Created by anthony on 02/09/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

public protocol YogaSectionOption {
    var title: String { get }
    var image: UIImage? { get }
}

extension SectionBuilder {

    public func yogaEventsCarousel(with events: @autoclosure @escaping () -> [YogaSectionOption], selectionClosure:  @escaping (YogaSectionOption) -> Void) -> CarouselSection {
        let sections = [yogaEvents(events: events(), selectionClosure: selectionClosure)]
        return carousel("Yoga_Events", sections: sections, height: YogaEventsSection.height, pagingEnabled: false)
    }

    public func yogaEvents(events: @autoclosure @escaping () -> [YogaSectionOption], selectionClosure:  @escaping ( YogaSectionOption) -> Void) -> YogaEventsSection {
        return YogaEventsSection(selectionClosure: selectionClosure).enumerate(events) as! YogaEventsSection
    }
}

extension YogaEventsSection: EnumeratableSection {
    public typealias DataType = YogaSectionOption
}

public class YogaEventsSection {

    fileprivate static let height: CGFloat = 160.0
    fileprivate let selectionClosure: (YogaSectionOption) -> Void

    public init(selectionClosure: @escaping (YogaSectionOption) -> Void) {
        self.selectionClosure = selectionClosure
    }
}

extension YogaEventsSection: ViewSection {

    public func createView() -> UIView {
        return YogaEventView()
    }

    public func size(in view: UIView, at index: Int) -> SectionCellSize {
        return SectionCellSize(width: (YogaEventsSection.height * 4/3) - YogaEventView.textHeight, height: YogaEventsSection.height)
    }

    public func configure(_ view: UIView, at index: Int) {
        let event = data[index]
        (view as? YogaEventView)?.set(title: event.title, image: event.image)
    }

    public func didSelect(_ view: UIView, at index: Int) {
        selectionClosure(data[index])
    }

    public var sectionInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: .keyline, bottom: 0.0, right: .keyline)
    }
    
    public var minimumInteritemSpacing: CGFloat {
        return .keyline
    }
    
    public var minimumLineSpacing: CGFloat {
        return .keyline
    }
    
}
