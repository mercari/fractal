//
//  GapSection.swift
//  SectionSystem
//
//  Created by Anthony Smith on 12/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import DesignSystem

extension SectionBuilder {
    public func seperator() -> GapSection {
        return GapSection(colorKey: .secondary, height: .large)
    }

    public func spacing(_ height: CGFloat = .medium, backgroundColorKey: UIColor.Key = .clear) -> GapSection {
        return GapSection(colorKey: backgroundColorKey, height: height)
    }
}

public class GapSection {
    fileprivate let colorKey: UIColor.Key
    fileprivate let height: CGFloat

    init(colorKey: UIColor.Key, height: CGFloat) {
        self.colorKey = colorKey
        self.height = height
    }
}

extension GapSection: ViewSection {

    public func createView() -> UIView {
        return UIView()
    }

    public func size(in view: UIView, at index: Int) -> SectionCellSize {
        return SectionCellSize(width: view.bounds.size.width, height: height)
    }

    public func configure(_ view: UIView, at index: Int) {
        view.backgroundColor = .background(colorKey)
    }
}
