//
//  PaletteOptionViewModel.swift
//  DesignSystemApp
//
//  Created by anthony on 15/01/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import DesignSystem

extension SectionBuilder {
    func paletteOptions(_ options: [BrandingManager.PaletteOption]) -> ColorPaletteOptionsSection {
        return ColorPaletteOptionsSection(options)
    }
}

class ColorPaletteOptionsSection {
    let options: [BrandingManager.PaletteOption]

    init(_ options: [BrandingManager.PaletteOption]) {
        self.options = options
    }
}

extension ColorPaletteOptionsSection: ViewSection {

    public func createView() -> UIView {
        return ColorPaletteOptionView()
    }

    public func size(in view: UIView, at index: Int) -> CGSize? {
        return CGSize(width: 100.0, height: 120.0)
    }

    public var itemCount: Int {
        return self.options.count
    }

    public func configure(_ view: UIView, at index: Int) {
        let option = self.options[index]
        (view as? ColorPaletteOptionView)?.set(name: option.name, color: option.color)
    }
}
