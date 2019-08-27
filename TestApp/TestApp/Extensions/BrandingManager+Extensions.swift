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
    static let check = UIColor.Key("check")
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

public extension UIImage.Key {
    static let logo = UIImage.Key("logo")
    static let icon0 = UIImage.Key("icon0")
    static let icon1 = UIImage.Key("icon1")
    static let icon2 = UIImage.Key("icon2")
    static let icon3 = UIImage.Key("icon3")
    static let icon4 = UIImage.Key("icon4")
    static let icon5 = UIImage.Key("icon5")
    static let icon6 = UIImage.Key("icon6")
    static let icon7 = UIImage.Key("icon7")
    static let icon8 = UIImage.Key("icon8")
}
