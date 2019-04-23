//
//  HexBrand+Button.swift
//  DesignSystem
//
//  Created by Anthony Smith on 08/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation

extension HexBrand: ButtonBrand {

    fileprivate func structure(for style: Button.Style) -> Structure {
        switch style {
        case .primary(let size):
            return Structure(background: .filled, color: .primary, size: size, corners: .default, padding: .default, icon: nil)
        case .secondary(let size):
            return Structure(background: .outlined, color: .primary, size: size, corners: .default, padding: .default, icon: nil)
        case .attention(let size):
            return Structure(background: .filled, color: .secondary, size: size, corners: .default, padding: .default, icon: nil)
        case .toggle(let size):
            return Structure(background: .outlinedTogglable, color: .primary, size: size, corners: .circle, padding: .default, icon: nil)
        case .textLink(let size):
            return Structure(background: .text, color: .primary, size: size, corners: .default, padding: .none, icon: nil)
        case .facebook(let size):
            return Structure(background: .filled, color: .facebook, size: size, corners: .default, padding: .default, icon: nil)
        case .google(let size):
            return Structure(background: .filled, color: .google, size: size, corners: .default, padding: .default, icon: nil)
        }
    }

    fileprivate struct Structure {

        fileprivate let background: Background
        fileprivate let color: Color
        fileprivate let size: Button.Style.Size
        fileprivate let corners: Corners
        fileprivate let padding: Padding
        fileprivate let icon: UIImage?

        fileprivate enum Padding {
            case `default`, none

            var points: CGFloat {
                switch self {
                case .none:
                    return 0.0
                case .default:
                    return .default
                }
            }
        }

        fileprivate enum Background {
            case filled, outlined, outlinedTogglable, text
        }

        fileprivate enum Color {
            case primary, secondary, light, facebook, google
        }

        fileprivate enum Corners {
            case `default`, circle

            func size(for height: CGFloat) -> CGFloat {
                switch self {
                case .default:
                    return height <= 24.0 ? 2.0 : 4.0
                case .circle:
                    return height/2 - 2.0
                }
            }
        }
    }
    
    public func widthPin(for style: Button.Style) -> Pin {

        let width = self.structure(for: style).size.width

        switch width {
        case .full:
            return .width(-.keyline*2)
        case .custom(let constant):
            return .width(asConstant: constant)
        default:
            return .none
        }
    }

    public func heightPin(for style: Button.Style) -> Pin {
        let heightValue = height(for: structure(for: style).size.height)
        return .height(asConstant: heightValue)
    }

    public func height(for heightType: Button.Style.Size.Height) -> CGFloat {
        switch heightType {
        case .small:
            return 32.0
        case .medium:
            return 48.0
        case .large:
            return 56.0
        case .natural:
            return typography(for: heightType).lineHeight
        }
    }

    private func typography(for heightType: Button.Style.Size.Height) -> BrandingManager.Typography {
        switch heightType {
        case .small:
            return .small
        case .medium, .large, .natural:
            return .medium
        }
    }

    private enum Color {
        case primary, primaryAccent, secondary, disabled, attention
    }

    private func color(_ type: Color) -> UIColor {
        switch type {
        case .primary:
            return Palette.blue300.color
        case .primaryAccent:
            return Palette.blue400.color
        case .secondary:
            return Palette.mono50.color
        case .disabled:
            return Palette.mono200.color
        case .attention:
            return Palette.red400.color
        }
    }

    public func configure(_ button: Button, with style: Button.Style) {

        // This is seperate to consider re-applying style to a button
        // I think it's contentious to whether we'd need buttons to be able to re-style after init.. so currently private
        // different resuse identifiers for example on a collectionview would be more performant

        let styleStructure = structure(for: style)

        let structureHeight = height(for: styleStructure.size.height)
        let structureTypography = typography(for: styleStructure.size.height)
        let padding = styleStructure.padding.points
        let cornerSize = styleStructure.corners.size(for: structureHeight)

        let y: CGFloat = styleStructure.background == .text ? -1.0 : (structureHeight - ceil(structureTypography.lineHeight)) / 2
        let x: CGFloat = styleStructure.background == .text ? 0.0 : padding
        button.contentEdgeInsets = UIEdgeInsets(top: y, left: x, bottom: y, right: x)
        button.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -x/2, bottom: 0.0, right: x * 1.5)

        button.titleLabel?.font = structureTypography.font
        button.layer.cornerRadius = cornerSize
        button.layer.borderWidth = 0.0

        button.setImage(styleStructure.icon, for: .normal)

        button.resetColors()
        button.removeShadow()

        switch (styleStructure.background, styleStructure.color) {
        case (.filled, .primary):

            button.setTitleColor(.text(.light), for: .normal)
            button.setBackgroundColor(color(.primary), for: .normal)

            button.setTitleColor(UIColor.text(.disabled), for: .disabled)
            button.setBackgroundColor(color(.disabled), for: .disabled)

        case (.filled, .secondary):

            button.setTitleColor(.text(.light), for: .normal)
            button.setBackgroundColor(color(.attention), for: .normal)

            button.setTitleColor(UIColor.text(.disabled), for: .disabled)
            button.setBackgroundColor(color(.disabled), for: .disabled)

        case (.filled, .light):

            let backgroundColor: UIColor = .background(.light)
            let textColor: UIColor = .text(.dark)

            button.setTitleColor(textColor, for: .normal)
            button.setBackgroundColor(backgroundColor, for: .normal)

            button.setTitleColor(textColor, for: .highlighted)
            button.setBackgroundColor(backgroundColor.darker(), for: .highlighted)

            button.setTitleColor(.text(.disabled), for: .disabled)
            button.setBackgroundColor(color(.disabled), for: .disabled)

        case (.outlined, .primary):

            button.layer.borderWidth = 1.0
            let baseColor: UIColor = color(.primary)

            button.setTitleColor(baseColor, for: .normal)
            button.setBorderColor(baseColor, for: .normal)
            button.setBackgroundColor(.clear, for: .normal)

            button.setTitleColor(baseColor, for: .highlighted)
            button.setBorderColor(baseColor, for: .highlighted)
            button.setBackgroundColor(baseColor.alpha(0.1), for: .highlighted)

            button.setTitleColor(.text(.disabled), for: .disabled)
            button.setBorderColor(color(.disabled), for: .disabled)
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

            button.setTitleColor(color(.disabled), for: .disabled)
            button.setBorderColor(color(.disabled), for: .disabled)
            button.setBackgroundColor(.clear, for: .disabled)

        case (.outlinedTogglable, _):

            button.layer.borderWidth = 1.0
            let baseColor: UIColor = color(.primary)

            button.setTitleColor(baseColor, for: .normal)
            button.setBorderColor(baseColor, for: .normal)
            button.setBackgroundColor(.clear, for: .normal)

            button.setTitleColor(baseColor, for: .highlighted)
            button.setBorderColor(baseColor, for: .highlighted)
            button.setBackgroundColor(baseColor.alpha(0.1), for: .highlighted)

            button.setTitleColor(.white, for: .selected)
            button.setBorderColor(baseColor, for: .selected)
            button.setBackgroundColor(baseColor, for: .selected)

            button.setTitleColor(color(.disabled), for: .disabled)
            button.setBorderColor(color(.disabled), for: .disabled)
            button.setBackgroundColor(.clear, for: .disabled)

        case (.text, .primary):

            let baseColor: UIColor = .text(.link)

            button.setTitleColor(baseColor, for: .normal)
            button.setBackgroundColor(.clear, for: .normal)

            button.setTitleColor(baseColor.darker(), for: .highlighted)
            button.setBackgroundColor(.clear, for: .highlighted)

            button.setTitleColor(color(.disabled), for: .disabled)
            button.setBackgroundColor(.clear, for: .disabled)

        case (.text, .light):

            let baseColor: UIColor = .background(.light)

            button.setTitleColor(baseColor, for: .normal)
            button.setBackgroundColor(.clear, for: .normal)

            button.setTitleColor(baseColor.darker(), for: .highlighted)
            button.setBackgroundColor(.clear, for: .highlighted)

            button.setTitleColor(color(.disabled), for: .disabled)
            button.setBackgroundColor(.clear, for: .disabled)

        case (_, .facebook):

            button.setTitleColor(.white, for: .normal)
            button.setBackgroundColor(.facebookBlue, for: .normal)

        case (_, .google):

            button.layer.borderWidth = 2.0
            let textColor: UIColor = .text()
            let borderColor: UIColor = .divider()
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
            Assert("Button style not implemented:\(styleStructure.background) color:\(styleStructure.color)")
        }
    }
}
