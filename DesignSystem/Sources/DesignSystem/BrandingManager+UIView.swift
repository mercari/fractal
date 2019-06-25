//
//  UIView+BrandingManager.swift
//  DesignSample
//
//  Created by Anthony Smith on 13/09/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit

public protocol Highlightable {
    func set(for highlighted: Bool, selected: Bool)
}

public enum ShadowDirection {
    case up, down
}

extension CGColor {
    fileprivate static let shadowColor = UIColor.atom(.shadow).cgColor
}

extension UIView {

    public func addShortShadow(_ direction: ShadowDirection = .down) {

        layer.shadowColor = CGColor.shadowColor
        layer.shadowOffset = CGSize(width: 0.0, height: direction == .up ? -1.0 : 1.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.1
    }

    public func addMediumShadow(_ direction: ShadowDirection = .down) {

        layer.shadowColor = CGColor.shadowColor
        layer.shadowOffset = CGSize(width: 0.0, height: direction == .up ? -4.0 : 4.0)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.06
    }

    public func addLongShadow(_ direction: ShadowDirection = .down) {

        layer.shadowColor = CGColor.shadowColor
        layer.shadowOffset = CGSize(width: 0.0, height: direction == .up ? -8.0 : 8.0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.16
    }

    public func removeShadow() {

        layer.shadowColor = nil
        layer.shadowOffset = .zero
        layer.shadowRadius = 0.0
        layer.shadowOpacity = 0.0
    }
}
