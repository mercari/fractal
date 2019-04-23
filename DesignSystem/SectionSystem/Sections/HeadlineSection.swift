//
//  HeadlineSection.swift
//  SectionSystem
//
//  Created by Anthony Smith on 12/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation


extension SectionBuilder {
    public func headline(_ title: String, style: HeadlineView.Style = .default) -> HeadlineSection {
        return HeadlineSection(title, style: style)
    }
}

public class HeadlineSection {
    fileprivate let title: String
    fileprivate let style: HeadlineView.Style

    public init(_ title: String, style: HeadlineView.Style = .default) {
        self.title = title
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

    public func configure(_ view: UIView, at index: Int) {
        (view as? HeadlineView)?.set(text: self.title)
    }
}
