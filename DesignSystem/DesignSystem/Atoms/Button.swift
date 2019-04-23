//
//  Button.swift
//  Mercari
//
//  Created by Anthony Smith on 31/10/2017.
//  Copyright © 2017 Mercari, Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIControl.State: Hashable {
    public var hashValue: Int {
        return Int(rawValue)
    }
}

private class ButtonLayer: CAGradientLayer {

    var borderColors: [UIControl.State: CGColor] = [:]
    var gradientColors: [UIControl.State: [CGColor]] = [:]

    override var borderColor: CGColor? { didSet { borderColors[.normal] = borderColor } }
    override var colors: [Any]? { didSet { gradientColors[.normal] = colors as? [CGColor] } }

    func updateColors(for state: UIControl.State) {
        super.borderColor = borderColors[state] ?? borderColors[.normal]
        super.colors = gradientColors[state] ?? gradientColors[.normal]
    }
}

final public class Button: UIButton {

    private var backgroundColors: [UIControl.State: UIColor] = [:]

    override public var backgroundColor: UIColor? { didSet { backgroundColors[.normal] = backgroundColor } }
    override public var isSelected: Bool { didSet { updateBackground() } }
    override public var isHighlighted: Bool { didSet { updateBackground() } }
    override public var isEnabled: Bool { didSet { updateBackground() } }

    override public class var layerClass: AnyClass {
        return ButtonLayer.self
    }

    private var buttonLayer: ButtonLayer? {
        return layer as? ButtonLayer
    }

    var gradientLayer: CAGradientLayer? {
        return layer as? CAGradientLayer
    }

    public convenience init(style: Button.Style) {
        self.init()
        guard let buttonBrand = BrandingManager.brand as? ButtonBrand else {
            Assert("BrandingManager.brand does not conform to protocol ButtonBrand");
            return
        }
        buttonBrand.configure(self, with: style)
    }

    public func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        backgroundColors[state] = color
        updateBackground()
    }

    public func setBorderColor(_ color: UIColor?, for state: UIControl.State) {
        buttonLayer?.borderColors[state] = color?.cgColor
        updateBackground()
    }

    public func setGradientColors(_ colors: [UIColor]?, for state: UIControl.State) {
        buttonLayer?.gradientColors[state] = colors?.map { $0.cgColor }
        updateBackground()
    }

    public func resetColors() {
        backgroundColors = [:]
        buttonLayer?.borderColors = [:]
        buttonLayer?.gradientColors = [:]
        updateBackground()
    }

    private func updateBackground() {
        let backgroundColor = backgroundColors[state] ?? alternativeBackgroundColor
        super.backgroundColor = backgroundColor

        buttonLayer?.updateColors(for: state)
    }

    private var alternativeBackgroundColor: UIColor? {
        let normal = backgroundColors[.normal]
        let selected = backgroundColors[.selected] ?? backgroundColors[.normal]

        switch state {
        case .highlighted, .selected, [.selected, .highlighted]:
            return normal?.darker()
        case .disabled:
            return normal?.alpha()
        case [.selected, .disabled]:
            return selected?.brighter()
        default:
            return normal
        }
    }
}
