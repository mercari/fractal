//
//  UIColor+Extensions.swift
//  DesignSample
//
//  Created by Anthony Smith on 28/08/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    private static let hexDivide: CGFloat = 255.0

    public var hexString: String {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb: Int = (Int)(r * UIColor.hexDivide) << 16 | (Int)(g * UIColor.hexDivide) << 8 | (Int)(b * UIColor.hexDivide) << 0

        return String(format: "#%06x", rgb)
    }

    public func brighter(_ brightness: CGFloat = 0.25) -> UIColor {
        return colorWithAppendingBrightness(1 + brightness)
    }

    public func darker(_ brightness: CGFloat = 0.25) -> UIColor {
        return colorWithAppendingBrightness(1 - brightness)
    }

    public func alpha(_ alpha: CGFloat = 0.5) -> UIColor {
        return withAlphaComponent(alpha)
    }

    private func colorWithAppendingBrightness(_ aBrightness: CGFloat) -> UIColor {
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0

        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: hue, saturation: saturation, brightness: brightness * aBrightness, alpha: alpha)
        }

        return self
    }

    public func equals(_ rhs: UIColor) -> Bool {
        var lhsR: CGFloat = 0.0
        var lhsG: CGFloat  = 0.0
        var lhsB: CGFloat = 0.0
        var lhsA: CGFloat  = 0.0
        getRed(&lhsR, green: &lhsG, blue: &lhsB, alpha: &lhsA)

        var rhsR: CGFloat = 0.0
        var rhsG: CGFloat  = 0.0
        var rhsB: CGFloat = 0.0
        var rhsA: CGFloat  = 0.0
        rhs.getRed(&rhsR, green: &rhsG, blue: &rhsB, alpha: &rhsA)

        return  lhsR == rhsR && lhsG == rhsG && lhsB == rhsB && lhsA == rhsA
    }
}