//
//  HexBrand+Button.swift
//  DesignSystem
//
//  Created by Anthony Smith on 08/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation

extension HexBrand: ButtonBrand {
    func typography(for heightType: Button.Atoms.Size.Height) -> Typography {
        switch heightType {
        case .small:
            return .small
        case .medium, .large:
            return .standard
        }
    }

    func height(for heightType: Button.Atoms.Size.Height) -> CGFloat {
        switch heightType {
        case .small:
            return 32.0
        case .medium:
            return 48.0
        case .large:
            return 56.0
        }
    }

    func cornerSize(for style: Button.Atoms.Corners, buttonHeight: CGFloat) -> CGFloat {
        switch style {
        case .default:
            return buttonHeight <= 24.0 ? 2.0 : 4.0
        case .circle:
            return (buttonHeight/2) - 2.0
        }
    }

    func refreshDesign(on button: Button) {

        // This is seperate to consider re-applying style to a button
        // I think it's contentious to whether we'd need buttons to be able to re-style after init.. so currently private
        // different resuse identifiers for example on a collectionview would be more performant

        guard let atoms = button.design?.atoms() else { return }

        let y: CGFloat = (atoms.size.height.points - ceil(atoms.typography.lineHeight)) / 2
        let x: CGFloat = .default
        button.contentEdgeInsets = UIEdgeInsets(top: y, left: x, bottom: y, right: x)
        button.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -x/2, bottom: 0.0, right: x * 1.5)

        button.titleLabel?.font = atoms.typography.font
        button.layer.cornerRadius = atoms.cornerSize
        button.layer.borderWidth = 0.0

        button.setImage(atoms.icon, for: .normal)

        button.resetColors()
        button.removeShadow()

        switch (atoms.background, atoms.color) {
        case (.filled, .primary):

            button.setTitleColor(.text(.light), for: .normal)
            button.setBackgroundColor(.button(.primary), for: .normal)

            button.setTitleColor(UIColor.text(.disabled), for: .disabled)
            button.setBackgroundColor(.button(.disabled), for: .disabled)

        case (.filled, .secondary):

            button.setTitleColor(.text(.light), for: .normal)
            button.setBackgroundColor(.button(.secondary), for: .normal)

            button.setTitleColor(UIColor.text(.disabled), for: .disabled)
            button.setBackgroundColor(.button(.disabled), for: .disabled)

        case (.filled, .light):

            let backgroundColor: UIColor = .background(.light)
            let textColor: UIColor = .text(.dark)

            button.setTitleColor(textColor, for: .normal)
            button.setBackgroundColor(backgroundColor, for: .normal)

            button.setTitleColor(textColor, for: .highlighted)
            button.setBackgroundColor(backgroundColor.darker(), for: .highlighted)

            button.setTitleColor(.text(.disabled), for: .disabled)
            button.setBackgroundColor(.button(.disabled), for: .disabled)

        case (.outlined, .primary):

            button.layer.borderWidth = 1.0
            let baseColor: UIColor = .button(.primary)

            button.setTitleColor(baseColor, for: .normal)
            button.setBorderColor(baseColor, for: .normal)
            button.setBackgroundColor(.clear, for: .normal)

            button.setTitleColor(baseColor, for: .highlighted)
            button.setBorderColor(baseColor, for: .highlighted)
            button.setBackgroundColor(baseColor.alpha(0.1), for: .highlighted)

            button.setTitleColor(.text(.disabled), for: .disabled)
            button.setBorderColor(.button(.disabled), for: .disabled)
            button.setBackgroundColor(.clear, for: .disabled)

        case (.outlined, .light):

            button.layer.borderWidth = 1.0
            let baseColor: UIColor = .background(.light)

            button.setTitleColor(baseColor, for: .normal)
            button.setBorderColor(baseColor, for: .normal)
            button.setBackgroundColor(.clear, for: .normal)

            button.setTitleColor(baseColor, for: .highlighted)
            button.setBorderColor(baseColor, for: .highlighted)
            button.setBackgroundColor(baseColor.alpha(0.1), for: .highlighted)

            button.setTitleColor(.button(.disabled), for: .disabled)
            button.setBorderColor(.button(.disabled), for: .disabled)
            button.setBackgroundColor(.clear, for: .disabled)

        case (.outlinedTogglable, _):

            button.layer.borderWidth = 1.0
            let baseColor: UIColor = .button(.primary)

            button.setTitleColor(baseColor, for: .normal)
            button.setBorderColor(baseColor, for: .normal)
            button.setBackgroundColor(.clear, for: .normal)

            button.setTitleColor(baseColor, for: .highlighted)
            button.setBorderColor(baseColor, for: .highlighted)
            button.setBackgroundColor(baseColor.alpha(0.1), for: .highlighted)

            button.setTitleColor(.white, for: .selected)
            button.setBorderColor(baseColor, for: .selected)
            button.setBackgroundColor(baseColor, for: .selected)

            button.setTitleColor(.button(.disabled), for: .disabled)
            button.setBorderColor(.button(.disabled), for: .disabled)
            button.setBackgroundColor(.clear, for: .disabled)

        case (.text, .primary):

            let baseColor: UIColor = .darkGray

            button.setTitleColor(baseColor, for: .normal)
            button.setBackgroundColor(.clear, for: .normal)

            button.setTitleColor(baseColor, for: .highlighted)
            button.setBackgroundColor(baseColor.alpha(0.1), for: .highlighted)

            button.setTitleColor(.button(.disabled), for: .disabled)
            button.setBackgroundColor(.clear, for: .disabled)

        case (.text, .light):

            let baseColor: UIColor = .background(.light)

            button.setTitleColor(baseColor, for: .normal)
            button.setBackgroundColor(.clear, for: .normal)

            button.setTitleColor(baseColor, for: .highlighted)
            button.setBackgroundColor(baseColor.alpha(0.1), for: .highlighted)

            button.setTitleColor(.button(.disabled), for: .disabled)
            button.setBackgroundColor(.clear, for: .disabled)

        case (_, .facebook):

            button.setTitleColor(.white, for: .normal)
            button.setBackgroundColor(.facebookBlue, for: .normal)

        case (_, .google):

            button.layer.borderWidth = 2.0
            let textColor: UIColor = .text() // TODO: define these here
            let borderColor: UIColor = .divider() // TODO: define these here
            let backgroundColor: UIColor = .white

            button.setTitleColor(textColor, for: .normal)
            button.setBorderColor(borderColor, for: .normal)
            button.setBackgroundColor(backgroundColor, for: .normal)

            button.setTitleColor(textColor, for: .highlighted)
            button.setBorderColor(borderColor.darker(0.1), for: .highlighted)
            button.setBackgroundColor(backgroundColor.darker(0.05), for: .highlighted)

            button.setTitleColor(textColor, for: .selected)
            button.setBorderColor(borderColor, for: .selected)
            button.setBackgroundColor(backgroundColor, for: .selected)

            button.setTitleColor(textColor.alpha(0.5), for: .disabled)
            button.setBorderColor(borderColor.alpha(0.5), for: .disabled)
            button.setBackgroundColor(backgroundColor.alpha(0.5), for: .disabled)

        default:
            Assert("Button configuration not implemented style:\(atoms.background) color:\(atoms.color)")
            break
        }
    }
}
