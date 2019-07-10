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
        return GapSection(color: .background(.secondary), height: .large)
    }

    // Workaround to avoid to be detected as a leak when using system static UIColors
    public func spacing(_ height: CGFloat = .medium, color: UIColor = .init(red: 0, green: 0, blue: 0, alpha: 0)) -> GapSection {
        return GapSection(color: color, height: height)
    }
}

public class GapSection {
    fileprivate let color: UIColor?
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

    public func size(in view: UIView, at index: Int) -> SectionCellSize {
        return SectionCellSize(width: view.bounds.size.width, height: self.height)
    }

    public func configure(_ view: UIView, at index: Int) {
        view.backgroundColor = self.color
    }
}
