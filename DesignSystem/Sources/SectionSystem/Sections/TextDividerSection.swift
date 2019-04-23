//
//  TextDividerSection.swift
//  SectionSystem
//
//  Created by anthony on 18/02/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation


extension SectionBuilder {
    public func textDivider(_ title: String, style: TextDividerView.Style = .noLine, backgroundColor: UIColor = .clear) -> TextDividerSection {
        return TextDividerSection(title, style: style, backgroundColor: backgroundColor)
    }
}

public class TextDividerSection {
    fileprivate let title: String
    fileprivate let style: TextDividerView.Style
    fileprivate let backgroundColor: UIColor

    init(_ title: String, style: TextDividerView.Style, backgroundColor: UIColor) {
        self.style = style
        self.backgroundColor = backgroundColor
        self.title = title
    }
}

extension TextDividerSection: ViewSection {

    public func createView() -> UIView {
        return TextDividerView(style: style)
    }

    public func size(in superview: UIView, at index: Int) -> CGSize? {
        let textHeight = title.height(typography: TextDividerView.typography, width: superview.bounds.size.width/2)
        return CGSize(width: superview.bounds.size.width, height: textHeight)
    }

    public func configure(_ view: UIView, at index: Int) {
        guard let textDivider = view as? TextDividerView else { return }
        textDivider.backgroundColor = backgroundColor
        textDivider.set(title: title, style: style)
    }
}
