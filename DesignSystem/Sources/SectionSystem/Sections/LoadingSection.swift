//
//  LoadingSection.swift
//  SectionSystem
//
//  Created by anthony on 13/03/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation


extension SectionBuilder {
    public func loading(_ style: LoadingView.Style = .gray, backgroundColor: UIColor = .clear) -> LoadingSection {
        return LoadingSection(style, backgroundColor: backgroundColor)
    }
}

public class LoadingSection {
    fileprivate let style: LoadingView.Style
    fileprivate let backgroundColor: UIColor

    public init(_ style: LoadingView.Style, backgroundColor: UIColor) {
        self.style = style
        self.backgroundColor = backgroundColor
    }
}

extension LoadingSection: ViewSection {

    public var reuseIdentifier: String {
        return "Loading_\(style.rawValue)"
    }

    public func createView() -> UIView {
        return LoadingView(style: style)
    }

    public func size(in view: UIView, at index: Int) -> CGSize {
        return CGSize(width: view.bounds.size.width, height: 40.0)
    }

    public func configure(_ view: UIView, at index: Int) {
        guard let loadingView = view as? LoadingView else { return }
        loadingView.set(loading: true)
        loadingView.backgroundColor = backgroundColor
    }
}
