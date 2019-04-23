//
//  DividerViewModel.swift
//  SectionSystem
//
//  Created by anthony on 19/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation


extension SectionBuilder {
    public func divider(_ style: DividerView.Style = .full, backgroundColor: UIColor = .background(.cell), height: CGFloat? = nil) -> DividerSection {
        return DividerSection(style, backgroundColor: backgroundColor, height: height)
    }
}

public class DividerSection {
    fileprivate let style: DividerView.Style
    fileprivate let backgroundColor: UIColor
    fileprivate let height: CGFloat?

    public init(_ style: DividerView.Style = .full, backgroundColor: UIColor = .background(.cell), height: CGFloat? = nil) {
        self.style = style
        self.backgroundColor = backgroundColor
        self.height = height
    }
}

extension DividerSection: ViewSection {
    public var reuseIdentifier: String {
        return "Divider_\(style.name)"
    }

    public func createView() -> UIView {
        return DividerView(style: style)
    }

    public func size(in superview: UIView, at index: Int) -> CGSize? {
        return CGSize(width: superview.bounds.size.width, height: self.height ?? self.style.height)
    }

    public func configure(_ view: UIView, at index: Int) {
        view.backgroundColor = self.backgroundColor
    }
}
