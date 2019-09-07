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
    func height(for size: Button.Size.Height) -> CGFloat
    func configure(_ button: Button, with style: Button.Style)
}

public extension Button.Style {
    static let primary   = Button.Style("primary")
    static let secondary = Button.Style("secondary")
    static let attention = Button.Style("attention")
    static let text      = Button.Style("text")
    static let toggle    = Button.Style("toggle")
}

public extension Brand {
    var resourceBundle: Bundle? { return nil }
}

public extension UIImage.Key {
    static let detailDisclosure = UIImage.Key("icn_disclosure_indicator")
    static let check            = UIImage.Key("check")
    static let smallArrow       = UIImage.Key("smallArrow")
}

public extension UIColor.Key {
    static let primary            = UIColor.Key("primary")
    static let secondary          = UIColor.Key("secondary")
    static let tertiary           = UIColor.Key("tertiary")
    static let cell               = UIColor.Key("cell")
    static let cellSelected       = UIColor.Key("cellSelected")
    static let detail             = UIColor.Key("detail")
    static let information        = UIColor.Key("information")
    static let light              = UIColor.Key("light")
    static let divider            = UIColor.Key("divider")
    static let shadow             = UIColor.Key("shadow")
    static let placeholder        = UIColor.Key("placeholder")
    static let refreshControl     = UIColor.Key("refreshControl")
    static let detailDisclosure   = UIColor.Key("detailDisclosure")
    static let switchPositiveTint = UIColor.Key("switchPositiveTint")
    static let switchNegativeTint = UIColor.Key("switchNegativeTint")
    static let sliderPositiveTint = UIColor.Key("sliderPositiveTint")
    static let sliderNegativeTint = UIColor.Key("sliderNegativeTint")
    static let warning            = UIColor.Key("warning")
    static let clear              = UIColor.Key("clear")
    static let missing            = UIColor.Key("missing")
}
