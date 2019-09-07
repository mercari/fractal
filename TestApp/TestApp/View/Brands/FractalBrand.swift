//
//  FractalBrand.swift
//  TestApp
//
//  Created by anthony on 28/05/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

class FractalBrand: Brand {

    var id: String = "FractalBrand"

    var keyboardAppearance: UIKeyboardAppearance = .light

    var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    var defaultCellHeight: CGFloat = 52.0

    func imageName(for key: UIImage.Key) -> String? {
        switch key {
        case .logo:
            return "fractal_large_light"
        default:
            return key.rawValue
        }
    }

    // MARK: - Spacing / Sizes

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
        case .padding:
            return 8.0
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

    // MARK: - Typography

    // ultraLight, thin, light, regular, medium, semibold, bold, heavy, strong, black

    func fontName(for typography: BrandingManager.Typography) -> String? {
        if typography.isStrong {
            switch typography {
            case .xxlarge, .xlarge, .large:
                return "Avenir-Black"
            default:
                return "Avenir-Medium"
            }
        }
        return "Avenir"
    }

    func fontWeight(for typography: BrandingManager.Typography) -> UIFont.Weight {

        guard let name = fontName(for: typography) else { return .regular }

        if name == "Avenir-Black" {
            return .black
        } else if name == "Avenir-Medium" {
            return .medium
        }

        return .regular
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

    // MARK: - Colors

    func atomColor(for key: UIColor.Key) -> UIColor {
        switch key {
        case .shadow:
            return .shadow
        case .warning:
            return .pink1
        case .sliderPositiveTint:
            return .blue
        case .sliderNegativeTint, .switchNegativeTint:
            return .mono3
        case .detailDisclosure:
            return .pink1
        case .switchPositiveTint:
            return .blue
        case .check:
            return .pink1
        case .divider:
            return .mono2
        case .clear:
            return .clear
        default:
            return .blue
        }
    }

    func brandColor(for key: UIColor.Key) -> UIColor {
        switch key {
        case .secondary:
            return .pink1
        case .tertiary:
            return .pink2
        default:
            return .blue
        }
    }

    func backgroundColor(for key: UIColor.Key) -> UIColor {
        switch key {
        case .cellSelected:
            return .pink3
        case .clear:
            return .clear
        case .missing:
            return .red
        default:
            return .mono
        }
    }

    func textColor(for key: UIColor.Key) -> UIColor {
        switch key {
        case .light:
            return .mono
        case .information:
            return .brand(.secondary)
        default:
            return .mono6
        }
    }
}

fileprivate extension UIColor {
    static let pink1  = #colorLiteral(red: 0.973, green: 0.522, blue: 0.502, alpha: 1)
    static let pink2  = #colorLiteral(red: 0.976, green: 0.725, blue: 0.714, alpha: 1)
    static let pink3  = #colorLiteral(red: 0.961, green: 0.890, blue: 0.890, alpha: 1)
    static let blue   = #colorLiteral(red: 0.659, green: 0.871, blue: 0.878, alpha: 1)
    static let mono6  = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
    static let mono5  = #colorLiteral(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
    static let mono4  = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    static let mono3  = #colorLiteral(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    static let mono2  = #colorLiteral(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    static let mono   = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
    static let shadow = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.18)
}

extension FractalBrand: ButtonBrand {

    func widthPin(for size: Button.Size) -> Pin {
        return .width(-.keyline*2)
    }
    
    func heightPin(for size: Button.Size) -> Pin {
        return .height(asConstant: height(for: size.height))
    }
    
    func height(for size: Button.Size.Height) -> CGFloat {
        return 48.0
    }
    
    func configure(_ button: Button, with style: Button.Style) {

        button.layer.cornerRadius = 3.0
        button.setTypography(.large)
        button.contentEdgeInsets = UIEdgeInsets(top: 0.0, left: .keyline, bottom: 0.0, right: .keyline)
        button.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -.keyline/2, bottom: 0.0, right: .keyline * 1.5)

        switch style {
        case .primary:
            button.setTitleColor(.text(.light), for: .normal)
            button.setBackgroundColor(.brand, for: .normal)
            button.setBackgroundColor(UIColor.brand.lighter(0.1), for: .highlighted)
            button.layer.borderWidth = 0.0
        case .secondary:
            button.setTitleColor(.atom(.warning), for: .normal)
            button.setTitleColor(.text(.light), for: .highlighted)
            button.setBackgroundColor(.clear, for: .normal)
            button.setBackgroundColor(UIColor.atom(.warning), for: .highlighted)
            button.layer.borderWidth = 2.0
            button.layer.borderColor = UIColor.atom(.warning).cgColor
        case .attention:
            button.setTitleColor(.text(.light), for: .normal)
            button.setBackgroundColor(.atom(.warning), for: .normal)
            button.setBackgroundColor(UIColor.atom(.warning).lighter(), for: .highlighted)
            button.layer.borderWidth = 0.0
        case .toggle:
            button.setTitleColor(.text(.light), for: .normal)
            button.setBackgroundColor(.brand, for: .normal)
            button.setBackgroundColor(UIColor.brand.lighter(0.1), for: .highlighted)
            button.setBackgroundColor(UIColor.brand.lighter(0.1), for: .selected)
            button.layer.borderWidth = 0.0
        default:
            button.setTitleColor(.text(.light), for: .normal)
            button.setBackgroundColor(.text, for: .normal)
            button.setBackgroundColor(UIColor.text.lighter(0.1), for: .highlighted)
            button.layer.borderWidth = 0.0
        }
    }
}

extension FractalBrand: NavigationControllerBrand {
    func applyBrand(to navigationBar: UINavigationBar) {
        let attributes: [NSAttributedString.Key: AnyObject] = [
            NSAttributedString.Key.font: BrandingManager.Typography.large.font,
            NSAttributedString.Key.foregroundColor: UIColor.brand]

        let largeAttributes: [NSAttributedString.Key: AnyObject] = [
            NSAttributedString.Key.font: BrandingManager.Typography.xxlarge.font,
            NSAttributedString.Key.foregroundColor: UIColor.brand]

        navigationBar.titleTextAttributes = attributes
        navigationBar.largeTitleTextAttributes = largeAttributes
        navigationBar.shadowImage = UIImage(color: .brand)
        navigationBar.barTintColor = .background
        navigationBar.tintColor = .brand
    }
}

extension FractalBrand: BrandTest {
    public var allTypographyCases: [BrandingManager.Typography] {
        let basicCases = BrandingManager.Typography.allCases
        let str = basicCases.map { BrandingManager.Typography($0.style, [.strong]) }
        let noAcc = basicCases.map { BrandingManager.Typography($0.style, [.noAccessibility]) }
        let strNoAcc = basicCases.map { BrandingManager.Typography($0.style, [.strong, .noAccessibility]) }
        return basicCases + str + noAcc + strNoAcc
    }

    var rawPalette: [BrandingManager.PaletteOption] {

        let array = [BrandingManager.PaletteOption(name: "pink1", color: .pink1),
                     BrandingManager.PaletteOption(name: "pink2", color: .pink2),
                     BrandingManager.PaletteOption(name: "pink3", color: .pink3),
                     BrandingManager.PaletteOption(name: "blue", color: .blue),
                     BrandingManager.PaletteOption(name: "mono6", color: .mono6),
                     BrandingManager.PaletteOption(name: "mono5", color: .mono5),
                     BrandingManager.PaletteOption(name: "mono4", color: .mono4),
                     BrandingManager.PaletteOption(name: "mono3", color: .mono3),
                     BrandingManager.PaletteOption(name: "mono2", color: .mono2),
                     BrandingManager.PaletteOption(name: "mono", color: .mono),
                     BrandingManager.PaletteOption(name: "shadow", color: .shadow)]
        return array
    }
}
