//
//  SegmentedOptionsSection.swift
//  SectionSystem
//
//  Created by acantallops on 2019/04/25.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

extension SectionBuilder {
    public func segmentedControl(_ items: [Any], observedIndex: Observable<Int?>, backgroundColor: UIColor = .background) -> SegmentedOptionsSection {
        return SegmentedOptionsSection(items: items, observedIndex: observedIndex, backgroundColor: backgroundColor)
    }
}

public class SegmentedOptionsSection {
    fileprivate let items: [Any]
    fileprivate let observedIndex: Observable<Int?>?
    fileprivate var suppressUpdate: Bool = false
    fileprivate let backgroundColor: UIColor
    init(items: [Any], observedIndex: Observable<Int?>, backgroundColor: UIColor) {
        self.items = items
        self.observedIndex = observedIndex
        self.backgroundColor = backgroundColor
        observedIndex.addObserver(self) { [weak self] (value) in
            guard let self = self else { return }
            guard !self.suppressUpdate else { self.suppressUpdate = false; return }
            (self.visibleView as? SegmentedControlView)?.set(value: value)
        }
    }
}

extension SegmentedOptionsSection: ViewSection {
    public func createView() -> UIView {
        return SegmentedControlView(items: items)
    }

    public func configure(_ view: UIView, at index: Int) {
        guard let segmentedControl = view as? SegmentedControlView else { return }
        segmentedControl.backgroundColor = backgroundColor
        segmentedControl.set(value: observedIndex?.value, didChangeClosure: { [weak self] (value) in
            guard let `self` = self else { return }
            self.suppressUpdate = true
            self.observedIndex?.value = value
        })
        segmentedControl.set(value: observedIndex?.value)
    }

    public func size(in view: UIView, at index: Int) -> SectionCellSize {
        return SectionCellSize(width: view.bounds.size.width, height: nil)
    }
}
