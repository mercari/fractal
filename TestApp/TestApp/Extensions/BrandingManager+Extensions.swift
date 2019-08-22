//
//  BrandingManager+Extensions.swift
//  TestApp
//
//  Created by anthony on 30/05/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

extension UIColor.Key {
    static let cellSelected = UIColor.Key("cellSelected")
    static let secondary =    UIColor.Key("secondary")
}

public protocol BrandTest {
    var rawPalette: [BrandingManager.PaletteOption] { get }
    var allTypographyCases: [BrandingManager.Typography] { get }
}

extension DefaultBrand: BrandTest {
    public var allTypographyCases: [BrandingManager.Typography] {

        let basicCases = BrandingManager.Typography.allCases
        let str = basicCases.map { BrandingManager.Typography($0.style, [.strong]) }
        let noAcc = basicCases.map { BrandingManager.Typography($0.style, [.noAccessibility]) }
        let strNoAcc = basicCases.map { BrandingManager.Typography($0.style, [.strong, .noAccessibility]) }
        return basicCases + str + noAcc + strNoAcc
    }

    public var rawPalette: [BrandingManager.PaletteOption] {
        return Palette.allCases.map { BrandingManager.PaletteOption(name: $0.rawValue, color: $0.color) }
    }
}

