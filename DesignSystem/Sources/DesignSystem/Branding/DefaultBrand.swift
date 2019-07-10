//
//  DefaultBrand.swift
//  DesignSystem
//
//  Created by anthony on 29/05/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation

class DefaultBrand: Brand {

    var id: String = "DefaultBrand"

    var keyboardAppearance: UIKeyboardAppearance = .default

    var preferredStatusBarStyle: UIStatusBarStyle { return .default }

    var defaultCellHeight: CGFloat = 44.0

    func value(for spacing: BrandingManager.Spacing) -> CGFloat {
        switch spacing {
        case .xxsmall:
            return 1.0
        case .xsmall:
            return 2.0
        case .small:
            return 4.0
        case .medium:
            return 8.0
        case .large:
            return 16.0
        case .xlarge:
            return 32.0
        case .xxlarge:
            return 64.0
        case .xxxlarge:
            return 128.0
        case .keyline:
            return 16.0
        case .divider:
            return 1.0
        }
    }

    func value(for size: BrandingManager.IconSize) -> CGSize {
        switch size {
        case .xsmall:
            return CGSize(width: 20.0, height: 20.0)
        case .small:
            return CGSize(width: 28.0, height: 28.0)
        case .medium:
            return CGSize(width: 40.0, height: 40.0)
        case .large:
            return CGSize(width: 64.0, height: 64.0)
        case .xlarge:
            return CGSize(width: 96.0, height: 96.0)
        case .xxlarge:
            return CGSize(width: 128.0, height: 128.0)
        }
    }

    func value(for color: BrandingManager.Color) -> UIColor {
        switch color {
        case .atom(let key):
            switch key {
            case .shadow:
                return Palette.shadow.color
            case .warning:
                return Palette.red.color
            case .sliderPositiveTint:
                return Palette.blue.color
            case .sliderNegativeTint:
                return Palette.mono2.color
            default:
                return Palette.blue.color
            }
        case .brand(_):
            return Palette.blue.color
        case .background(let key):
            switch key {
            case .cell:
                return Palette.mono.color
            default:
                return Palette.mono2.color
            }
        case .divider(_):
            return Palette.mono3.color
        case .text(let key):
            switch key {
            case .detail:
                return Palette.mono4.color
            case .information:
                return Palette.blue.color
            case .light:
                return Palette.mono.color
            default:
                return Palette.mono6.color
            }
        }
    }

    func fontName(for fontWeight: UIFont.Weight) -> String? {
        return nil
    }

    public func fontSize(for typography: BrandingManager.Typography) -> CGFloat {
        var size: CGFloat

        switch typography {
        case .xxlarge:
            size = 32.0
        case .xlarge:
            size = 28.0
        case .large:
            size = 20.0
        case .medium:
            size = 16.0
        case .small:
            size = 14.0
        case .xsmall:
            size = 12.0
        case .xxsmall:
            size = 10.0
        default:
            size = 16.0
        }

        if typography.useAccessibility {
            size += fontSizeAdjustment(for: typography)
        }

        return size
    }

    private func fontSizeAdjustment(for typography: BrandingManager.Typography) -> CGFloat {
        switch (typography, BrandingManager.contentSizeCategory) {
        case (.xxsmall, .extraSmall),
             (.xxsmall, .small):
            return 0.0
        case (_, .extraSmall):
            return -2.0
        case (_, .small):
            return -1.0
        case (_, .extraLarge):
            return 1.0
        case (_, .extraExtraLarge):
            return 2.0
        case (_, .extraExtraExtraLarge):
            return 3.0
        case (_, .accessibilityMedium):
            return 4.0
        case (_, .accessibilityLarge):
            return 5.0
        case (_, .accessibilityExtraLarge):
            return 6.0
        case (_, .accessibilityExtraExtraLarge), (_, .accessibilityExtraExtraExtraLarge):
            return 7.0
        default: // unspecified, medium & large
            return 0.0
        }
    }

    public func fontWeight(for typography: BrandingManager.Typography) -> UIFont.Weight {
        if typography.isStrong {
            switch typography {
            case .xxlarge, .xlarge, .large:
                return .bold
            default:
                return .semibold
            }
        }
        return .regular
    }

    func defaultFontColor(for typography: BrandingManager.Typography) -> UIColor {
        return Palette.mono6.color
    }

    internal enum Palette: String, CaseIterable {

        case blue, red,
        mono6, mono5, mono4, mono3, mono2, mono,
        shadow, facebook

        var color: UIColor {
            switch self {
            case .blue:
                return #colorLiteral(red: 0.208, green: 0.486, blue: 0.965, alpha: 1)
            case .red:
                return #colorLiteral(red: 0.910, green: 0.2, blue: 0.149, alpha: 1)
            case .mono6:
                return #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
            case .mono5:
                return #colorLiteral(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
            case .mono4:
                return #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            case .mono3:
                return #colorLiteral(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            case .mono2:
                return #colorLiteral(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            case .mono:
                return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
            case .shadow:
                return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.18)
            case .facebook:
                return #colorLiteral(red: 0.26, green: 0.40, blue: 0.70, alpha: 1.0)
            }
        }
    }

    var rawPalette: [BrandingManager.PaletteOption] {
        return Palette.allCases.map { BrandingManager.PaletteOption(name: $0.rawValue, color: $0.color) }
    }
}

extension DefaultBrand: ButtonBrand {

    func widthPin(for size: Button.Size) -> Pin {
        return .width(-.keyline*2)
    }

    func heightPin(for size: Button.Size) -> Pin {
        return .height(asConstant: 52.0)
    }

    func configure(_ button: Button, with style: Button.Style) {
        switch style {
        case .primary:
            button.setTitleColor(.text(.light), for: .normal)
            button.setBackgroundColor(.brand(), for: .normal)
            button.setBackgroundColor(UIColor.brand().darker(), for: .highlighted)
            button.layer.borderWidth = 0.0
        case .secondary:
            button.setTitleColor(.brand(), for: .normal)
            button.setTitleColor(UIColor.brand().darker(), for: .highlighted)
            button.setBackgroundColor(.clear, for: .normal)
            button.setBackgroundColor(UIColor.brand(), for: .highlighted)
            button.layer.borderWidth = 2.0
            button.layer.borderColor = UIColor.brand().cgColor
        case .attention:
            button.setTitleColor(.text(.light), for: .normal)
            button.setBackgroundColor(.atom(.warning), for: .normal)
            button.setBackgroundColor(UIColor.atom(.warning).darker(), for: .highlighted)
            button.layer.borderWidth = 0.0
        case .toggle:
            button.setTitleColor(.text(.light), for: .normal)
            button.setBackgroundColor(.brand(), for: .normal)
            button.setBackgroundColor(UIColor.brand().darker(), for: .highlighted)
            button.setBackgroundColor(UIColor.brand().darker().darker(), for: .selected)
            button.layer.borderWidth = 0.0
        default:
            button.setTitleColor(.text(.light), for: .normal)
            button.setBackgroundColor(.text(), for: .normal)
            button.setBackgroundColor(UIColor.text().darker(), for: .highlighted)
            button.layer.borderWidth = 0.0
        }
    }
}
