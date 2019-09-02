//
//  YogaOptionsSection.swift
//  TestApp
//
//  Created by anthony on 02/09/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

public protocol YogaOption {
    var title: String { get }
    var image: UIImage { get }
}

extension SectionBuilder {

    public func yogaEventsCarousel(in parent: SectionViewController, events: @escaping () -> [YogaOption], selectionClosure:  @escaping (Int, YogaOption) -> Void) -> CarouselSection {
        let dataSource = SectionControllerDataSource(viewController: parent)
        dataSource.sections = [yogaEvents(events: events, selectionClosure: selectionClosure)]
        return carousel("Yoga_Events", dataSource: dataSource, height: YogaEventsSection.cellSize.height, pagingEnabled: false)
    }

    public func yogaEvents(events: @escaping () -> [YogaOption], selectionClosure:  @escaping (Int, YogaOption) -> Void) -> YogaEventsSection {
        return YogaEventsSection(selectionClosure: selectionClosure).enumerate(events) as! YogaEventsSection
    }
}

extension YogaEventsSection: EnumeratableSection {
    public typealias DataType = YogaOption
}

public class YogaEventsSection {

    fileprivate static let cellSize: CGSize = CGSize(width: 200.0, height: 120.0)
    fileprivate let selectionClosure: (Int, YogaOption) -> Void

    public init(selectionClosure: @escaping (Int, YogaOption) -> Void) {
        self.selectionClosure = selectionClosure
    }
}

extension YogaEventsSection: ViewSection {

    public func createView() -> UIView {
        return YogaEventView()
    }

    public func size(in view: UIView, at index: Int) -> SectionCellSize {
        return SectionCellSize(width: YogaEventsSection.cellSize.width, height: YogaEventsSection.cellSize.height)
    }

    public func configure(_ view: UIView, at index: Int) {
        let event = data[index]
        (view as? YogaEventView)?.set(title: event.title, image: event.image)
    }

    public func didSelect(_ view: UIView, at index: Int) {
        selectionClosure(index, data[index])
    }
}
