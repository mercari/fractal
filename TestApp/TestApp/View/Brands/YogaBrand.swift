//
//  YogaBrand.swift
//  TestApp
//
//  Created by anthony on 26/08/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

class YogaBrand: Brand {
    
    var id: String = "YogaBrand"
    
    var keyboardAppearance: UIKeyboardAppearance = .dark
    
    var preferredStatusBarStyle: UIStatusBarStyle { return .default }
    
    var defaultCellHeight: CGFloat = 52.0
    
    func imageName(for key: UIImage.Key) -> String? {
        switch key {
        default:
            return key.rawValue
        }
    }
    
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
    
    func fontName(for typography: BrandingManager.Typography) -> String? {
        return nil // Defaults to SF
    }
    
    // ultraLight, thin, light, regular, medium, semibold, bold, heavy, strong, black
    func fontWeight(for typography: BrandingManager.Typography) -> UIFont.Weight {
        return .bold
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
            return .red
        case .sliderPositiveTint:
            return .green
        case .sliderNegativeTint:
            return .mono3
        case .switchPositiveTint:
            return .lightGreen
        case .switchNegativeTint:
            return .mono5
        case .detailDisclosure:
            return .green
        case .check:
            return .green
        case .divider:
            return .mono5
        case .clear:
            return .clear
        default:
            return .green
        }
    }
    
    func brandColor(for key: UIColor.Key) -> UIColor {
        switch key {
        case .secondary:
            return .lightGreen
        case .tertiary:
            return .darkGreen
        default:
            return .green
        }
    }
    
    func backgroundColor(for key: UIColor.Key) -> UIColor {
        switch key {
        case .cellSelected:
            return UIColor(white: 0.0, alpha: 0.1)
        case .clear:
            return .clear
        case .secondary:
            return .mono5
        case .tertiary:
            return .mono3
        case .heroBg:
            return .mono5
        case .missing:
            return .red
        default:
            return .mono4
        }
    }
    
    func textColor(for key: UIColor.Key) -> UIColor {
        switch key {
        case .light:
            return .mono
        case .information:
            return .mono2
        default:
            return .mono
        }
    }
}

fileprivate extension UIColor {
    static let lightGreen = #colorLiteral(red: 0.527, green: 0.802, blue: 0.684, alpha: 1)
    static let green      = #colorLiteral(red: 0.427, green: 0.702, blue: 0.584, alpha: 1)
    static let darkGreen  = #colorLiteral(red: 0.327, green: 0.602, blue: 0.484, alpha: 1)
    static let red        = #colorLiteral(red: 0.714, green: 0.318, blue: 0.325, alpha: 1)
    static let mono6      = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
    static let mono5      = #colorLiteral(red: 0.129, green: 0.137, blue: 0.165, alpha: 1)
    static let mono4      = #colorLiteral(red: 0.176, green: 0.188, blue: 0.212, alpha: 1)
    static let mono3      = #colorLiteral(red: 0.243, green: 0.263, blue: 0.286, alpha: 1)
    static let mono2      = #colorLiteral(red: 0.455, green: 0.494, blue: 0.541, alpha: 1)
    static let mono       = #colorLiteral(red:0.890, green: 0.902, blue: 0.922, alpha: 1)
    static let shadow     = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.18)
}

extension YogaBrand: ButtonBrand {
    
    func widthPin(for size: Button.Size) -> Pin {
        return .width(-.keyline*2)
    }
    
    func heightPin(for size: Button.Size) -> Pin {
        return .height(asConstant: 48.0)
    }
    
    func height(for size: Button.Size.Height) -> CGFloat {
        return 48.0
    }
    
    func configure(_ button: Button, with style: Button.Style) {
        
        button.contentEdgeInsets = UIEdgeInsets(top: 0.0, left: .keyline, bottom: 0.0, right: .keyline)
        button.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -.keyline/2, bottom: 0.0, right: .keyline * 1.5)
        
        switch style {
        case .primary:
            button.setTypography(.medium)
            button.layer.cornerRadius = 24.0
            button.setTitleColor(.text, for: .normal)
            button.setBackgroundColor(.background(.secondary), for: .normal)
            button.setBackgroundColor(UIColor.background(.secondary).darker(0.1), for: .highlighted)
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.brand.cgColor
        case .secondary:
            button.setTypography(.small)
            button.layer.cornerRadius = 8.0
            button.setTitleColor(.text, for: .normal)
            button.setBackgroundColor(.clear, for: .normal)
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.background(.tertiary).cgColor
        case .attention:
            button.setTypography(.medium)
            button.layer.cornerRadius = 24.0
            button.setTitleColor(.text(.light), for: .normal)
            button.setBackgroundColor(.atom(.warning), for: .normal)
            button.setBackgroundColor(UIColor.atom(.warning).lighter(), for: .highlighted)
            button.layer.borderWidth = 0.0
        case .toggle:
            button.setTypography(.medium)
            button.layer.cornerRadius = 24.0
            button.setTitleColor(.text(.light), for: .normal)
            button.setBackgroundColor(.brand, for: .normal)
            button.setBackgroundColor(UIColor.brand.lighter(0.1), for: .highlighted)
            button.setBackgroundColor(UIColor.brand.lighter(0.1), for: .selected)
            button.layer.borderWidth = 0.0
        default:
            button.setTypography(.medium)
            button.layer.cornerRadius = 8.0
            button.setTitleColor(.text(.light), for: .normal)
            button.setBackgroundColor(.text, for: .normal)
            button.setBackgroundColor(UIColor.text.lighter(0.1), for: .highlighted)
            button.layer.borderWidth = 0.0
        }
    }
}

extension YogaBrand: NavigationControllerBrand {
    func applyBrand(to navigationBar: UINavigationBar) {
        
        let attributes: [NSAttributedString.Key: AnyObject] = [
            NSAttributedString.Key.font: BrandingManager.Typography.large.font,
            NSAttributedString.Key.foregroundColor: UIColor.text(.secondary)]
        
        let largeAttributes: [NSAttributedString.Key: AnyObject] = [
            NSAttributedString.Key.font: BrandingManager.Typography.xxlarge.font,
            NSAttributedString.Key.foregroundColor: UIColor.text(.secondary)]
        
        navigationBar.titleTextAttributes = attributes
        navigationBar.largeTitleTextAttributes = largeAttributes
        navigationBar.shadowImage = UIImage(color: .background(.secondary))
        navigationBar.barTintColor = .background(.secondary)
        navigationBar.tintColor = .text(.secondary)
        navigationBar.isOpaque = true
    }
}

extension YogaBrand: TabBarControllerBrand {
    func applyBrand(to tabBar: UITabBar) {
        tabBar.shadowImage = UIImage(color: .atom(.divider))
        tabBar.barTintColor = .background
        tabBar.tintColor = .brand
    }
}

extension YogaBrand: BrandTest {
    public var allTypographyCases: [BrandingManager.Typography] {
        let basicCases = BrandingManager.Typography.allCases
        let str = basicCases.map { BrandingManager.Typography($0.style, [.strong]) }
        let noAcc = basicCases.map { BrandingManager.Typography($0.style, [.noAccessibility]) }
        let strNoAcc = basicCases.map { BrandingManager.Typography($0.style, [.strong, .noAccessibility]) }
        return basicCases + str + noAcc + strNoAcc
    }
    
    var rawPalette: [BrandingManager.PaletteOption] {

        let array = [BrandingManager.PaletteOption(name: "light green", color: .lightGreen),
                     BrandingManager.PaletteOption(name: "green",       color: .green),
                     BrandingManager.PaletteOption(name: "dark green",  color: .darkGreen),
                     BrandingManager.PaletteOption(name: "mono6",       color: .mono6),
                     BrandingManager.PaletteOption(name: "mono5",       color: .mono5),
                     BrandingManager.PaletteOption(name: "mono4",       color: .mono4),
                     BrandingManager.PaletteOption(name: "mono3",       color: .mono3),
                     BrandingManager.PaletteOption(name: "mono2",       color: .mono2),
                     BrandingManager.PaletteOption(name: "mono",        color: .mono),
                     BrandingManager.PaletteOption(name: "shadow",      color: .shadow)]
        return array
    }
}

extension YogaBrand: HeroImageBrand {
    var heroCornerRadius: CGFloat {
        return .medium
    }
    
    var heroEdgeInsets: UIEdgeInsets {
        return UIEdgeInsets(top: .keyline, left: .keyline, bottom: .keyline, right: .keyline)
    }
}
