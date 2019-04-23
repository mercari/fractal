//
//  GapSection.swift
//  SectionSystem
//
//  Created by Anthony Smith on 12/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation

extension SectionBuilder {
    public func seperator() -> GapSection {
        return GapSection(color: .background(.secondary), height: .default)
    }

    public func spacing(_ height: CGFloat = .default, color: UIColor = .clear) -> GapSection {
        return GapSection(color: color, height: height)
    }
}

public class GapSection {
    fileprivate let color: UIColor
    fileprivate let height: CGFloat

    init(color: UIColor, height: CGFloat) {
        self.color = color
        self.height = height
    }
}

extension GapSection: ViewSection {

    public func createView() -> UIView {
        return UIView()
    }

    public func size(in view: UIView, at index: Int) -> CGSize? {
        return CGSize(width: view.bounds.size.width, height: self.height)
    }

    public func configure(_ view: UIView, at index: Int) {
        view.backgroundColor = self.color
    }
}
