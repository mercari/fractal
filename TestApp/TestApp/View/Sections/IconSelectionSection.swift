//
//  IconSelectionSection.swift
//  TestApp
//
//  Created by anthony on 11/07/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

protocol IconOptions {
    var imageKey: UIImage.Key { get }
    var isSelected: Bool { get set }
}

extension SectionBuilder {
    func iconSelection(_ optionsClosure: @autoclosure @escaping () -> [IconOptions], layout: IconSelectionSection.Layout = .widthBased) -> IconSelectionSection {
        return IconSelectionSection(optionsClosure, layout).enumerate(optionsClosure) as! IconSelectionSection
    }
}

extension IconSelectionSection: EnumeratableSection {
    public typealias DataType = IconOptions
}

class IconSelectionSection {

    enum Layout: String {
        case heightBased, widthBased
    }

    private let layout: Layout

    fileprivate init(_ optionsClosure: @escaping () -> [IconOptions], _ layout: Layout) {
        self.layout = layout
    }
}

extension IconSelectionSection: ViewSection {

    public var reuseIdentifier: String {
        return "IconSelectionSection_\(layout.rawValue)"
    }

    public func createView() -> UIView {
        return IconSelectView()
    }

    public func size(in view: UIView, at index: Int) -> SectionCellSize {
        return SectionCellSize(width: 100.0, height: 120.0)
    }

    public var itemCount: Int {
        return data.count
    }

    public func configure(_ view: UIView, at index: Int) {
        let option = data[index]
        (view as? IconSelectView)?.set(option.imageKey, isSelected: option.isSelected)
    }
}
