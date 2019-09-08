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
