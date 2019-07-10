//
//  Button+BrandingManager.swift
//  Mercari
//
//  Created by Anthony Smith on 29/08/2018.
//  Copyright © 2018 Mercari, Inc. All rights reserved.
//

import UIKit

public protocol ButtonBrand {
    func widthPin(for size: Button.Size) -> Pin
    func heightPin(for size: Button.Size) -> Pin
    func configure(_ button: Button, with style: Button.Style)
}

public extension Button.Style {
    static let primary = Button.Style("primary")
    static let secondary = Button.Style("secondary")
    static let attention = Button.Style("attention")
    static let text = Button.Style("text")
    static let toggle = Button.Style("toggle")
}

public extension BrandingManager.Color.Key {
    static let primary = BrandingManager.Color.Key("primary")
    static let secondary = BrandingManager.Color.Key("secondary")
    static let tertiary = BrandingManager.Color.Key("tertiary")
    static let cell = BrandingManager.Color.Key("cell")
    static let detail = BrandingManager.Color.Key("detail")
    static let information = BrandingManager.Color.Key("information")
    static let light = BrandingManager.Color.Key("light")
    static let shadow = BrandingManager.Color.Key("shadow")
    static let placeholder = BrandingManager.Color.Key("placeholder")
    static let refreshControl = BrandingManager.Color.Key("refreshControl")
    static let switchPositiveTint = BrandingManager.Color.Key("switchPositiveTint")
    static let switchNegativeTint = BrandingManager.Color.Key("switchNegativeTint")
    static let sliderPositiveTint = BrandingManager.Color.Key("sliderPositiveTint")
    static let sliderNegativeTint = BrandingManager.Color.Key("sliderNegativeTint")
    static let warning = BrandingManager.Color.Key("warning")
}
