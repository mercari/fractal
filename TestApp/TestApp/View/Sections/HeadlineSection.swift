//
//  HeadlineSection.swift
//  SectionSystem
//
//  Created by Anthony Smith on 12/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import DesignSystem

extension SectionBuilder {
    public func headline(_ title: String, style: HeadlineView.Style = .default) -> HeadlineSection {
        return HeadlineSection(style).enumerate({ [title] }) as! HeadlineSection
    }

    public func headline(_ style: HeadlineView.Style = .default) -> HeadlineSection {
        return HeadlineSection(style)
    }

    public func headline(_ data: @escaping () -> [String], _ style: HeadlineView.Style = .default) -> HeadlineSection {
        return HeadlineSection(style).enumerate(data) as! HeadlineSection
    }
}

public class HeadlineSection {

    fileprivate let style: HeadlineView.Style

    public init(_ style: HeadlineView.Style = .default) {
        self.style = style
    }
}

extension HeadlineSection: ViewSection {

    public var reuseIdentifier: String {
        return "Headline_\(style.rawValue)"
    }

    public func createView() -> UIView {
        return HeadlineView(style: style)
    }

    public func size(in view: UIView, at index: Int) -> SectionCellSize {
        let textHeight = data[index].height(typography: style.typography, width: view.bounds.size.width - .keyline*2)
        return SectionCellSize(width: view.bounds.size.width, height: textHeight + .small + style.topPadding)
    }
    
    public func configure(_ view: UIView, at index: Int) {
        (view as? HeadlineView)?.set(text: data[index])
    }
}

extension HeadlineSection: EnumeratableSection {
    public typealias DataType = String
}
