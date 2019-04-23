//
//  HexBrand.swift
//  DesignSample
//
//  Created by Anthony Smith on 03/10/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit

public class HexBrand: Brand { // New brand

    public var uid: BrandingManager.BrandUid { return .hex }

    public var keyboardAppearance: UIKeyboardAppearance { return .light }

    public func value(for spacing: BrandingManager.Spacing) -> CGFloat {
        switch spacing {
        case .xxsmall:
            return 4.0
        case .xsmall:
            return 8.0
        case .small:
            return 12.0
        case .default:
            return 16.0
        case .medium:
            return 24.0
        case .large:
            return 32.0
        case .xlarge:
            return 40.0
        case .xxlarge:
            return 48.0
        case .xxxlarge:
            return 56.0

        case .divider:
            return 1.0
        case .keyline:
            return .default
        }
    }

    public func value(for size: BrandingManager.IconSize) -> CGSize {

        let value: CGFloat

        switch size {
        case .xsmall:
            value = 8.0
        case .small:
            value = 12.0
        case .medium:
            value = 24.0
        case .large:
            value = 32.0
        case .xlarge:
            value = 40.0
        case .xxlarge:
            value = 56.0
        }

        return CGSize (width: value, height: value)
    }

    // MARK: - Typography

    public func fontName(for fontWeight: UIFont.Weight) -> String? {
        return nil
    }

    public func fontSize(for typography: BrandingManager.Typography, overrideAdjustment: Bool) -> CGFloat {
        var size: CGFloat

        switch typography {
        case .xxlarge, .xxlargeStrong, .xxlargeNoAccessibility, .xxlargeStrongNoAccessibility:
            size = 27.0
        case .xlarge, .xlargeStrong, .xlargeNoAccessibility, .xlargeStrongNoAccessibility:
            size = 24.0
        case .large, .largeStrong, .largeNoAccessibility, .largeStrongNoAccessibility:
            size = 17.0
        case .medium, .mediumStrong, .mediumNoAccessibility, .mediumStrongNoAccessibility:
            size = 15.0
        case .small, .smallStrong, .smallNoAccessibility, .smallStrongNoAccessibility:
            size = 14.0
        case .xsmall, .xsmallStrong, .xsmallNoAccessibility, .xsmallStrongNoAccessibility:
            size = 12.0
        case .xxsmall, .xxsmallStrong, .xxsmallNoAccessibility, .xxsmallStrongNoAccessibility:
            size = 10.0
        }

        if !overrideAdjustment {
            size += fontSizeAdjustment(for: typography)
        }

        return size
    }

    //TODO: We need to subscribe to NSNotification.Name.UIContentSizeCategoryDidChange and reload our content accordingly
    private func fontSizeAdjustment(for typography: BrandingManager.Typography) -> CGFloat {
        switch (typography, BrandingManager.contentSizeCategory) {
        case (.xxsmall, .extraSmall), (.xxsmallStrong, .extraSmall),
             (.xxsmall, .small), (.xxsmallStrong, .small):
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
        switch typography {
        case .xxlargeStrong, .xlargeStrong, .largeStrong, .mediumStrong, .smallStrong, .xsmallStrong, .xxsmallStrong,
             .xxlargeStrongNoAccessibility, .xlargeStrongNoAccessibility, .largeStrongNoAccessibility, .mediumStrongNoAccessibility,
             .smallStrongNoAccessibility, .xsmallStrongNoAccessibility, .xxsmallStrongNoAccessibility:
            return .semibold
        case .xxlarge, .xlarge, .large, .medium, .small, .xsmall, .xxsmall,
             .xxlargeNoAccessibility, .xlargeNoAccessibility, .largeNoAccessibility, .mediumNoAccessibility,
             .smallNoAccessibility, .xsmallNoAccessibility, .xxsmallNoAccessibility:
            return .regular
        }
    }

    public func defaultFontColor(for typography: BrandingManager.Typography) -> UIColor {
        switch typography {
        case .small, .xsmall, .xxsmall, .smallNoAccessibility, .xsmallNoAccessibility, .xxsmallNoAccessibility:
            return text(.information)
        default:
            return text(.primary)
        }
    }

    // MARK: - Colors

    public func value(for color: BrandingManager.Color) -> UIColor {
        switch color {
        case .brand(let brandType):
            return brand(brandType)
        case .background(let bgType):
            return background(bgType)
        case .divider(let dividerType):
            return divider(dividerType)
        case .text(let textType):
            return text(textType)
        case .refreshControl:
            return Palette.red300.color
        case .disclosure:
            return Palette.mono600.color
        case .navigationShadow:
            return Palette.mono200.color
        case .shadow:
            return Palette.shadow.color
        case .sliderPositiveTint:
            return Palette.blue300.color
        case .sliderNegativeTint:
            return Palette.mono200.color
        default:
            Assert("This isn't set \(color)")
            return .green
        }
    }

    private func divider(_ type: BrandingManager.Color.DividerColor) -> UIColor {
        switch type {
        case .primary:
            return Palette.mono200.color
        case .secondary:
            return Palette.mono500.color
        default:
            return Palette.mono400.color
        }
    }

    private func brand(_ type: BrandingManager.Color.BrandColor) -> UIColor {
        switch type {
        case .primaryAccent:
            return Palette.red300.color
        default:
            return Palette.red400.color
        }
    }

    private func background(_ type: BrandingManager.Color.BackgroundColor) -> UIColor {
        switch type {
        case .primary, .light, .cell, .navigationBar:
            return Palette.mono50.color
        case .secondary:
            return Palette.mono200.color
        case .tertiary:
            return Palette.mono400.color
        case .accent:
            return Palette.blue300.color
        case .attention:
            return Palette.blue400.color
        case .information:
            return Palette.mono600.color
        case .cellSelected:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.04) // 0x000000 0.04 alpha
        case .layerDark:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6023651541) // 0x000000 0.6 alpha
        case .layerMiddle:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3995612158) // 0x000000 0.4 alpha
        case .layerLight:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1778949058) // 0x000000 0.18 alpha
        }
    }

    private func text(_ type: BrandingManager.Color.TextColor) -> UIColor {
        switch type {
        case .primary, .title, .dark:
            return Palette.mono600.color
        case .information:
            return Palette.mono500.color
        case .light, .chat, .chatUser:
            return Palette.mono100.color
        case .hint, .placeholder:
            return Palette.mono400.color
        case .disabled:
            return Palette.mono500.color
        case .link:
            return Palette.blue300.color
        }
    }

    internal enum Palette: String, CaseIterable {

        case blue400, blue300, blue200, blue100, blue50,
        red400, red300, red200, red100, red50,
        green300, green50,
        mono600, mono500, mono400, mono200, mono100, mono50,
        shadow

        var color: UIColor {
            switch self {
            case .blue400:
                return #colorLiteral(red: 0.0, green: 0.4549019607843137, blue: 0.7647058823529411, alpha: 1) // 0x0074c3
            case .blue300:
                return #colorLiteral(red: 0.0, green: 0.6196078431372549, blue: 0.9882352941176471, alpha: 1) // 0x009efc
            case .blue200:
                return #colorLiteral(red: 0.30196078431372547, green: 0.788235294117647, blue: 1.0, alpha: 1) // 0x4dc9ff
            case .blue100:
                return #colorLiteral(red: 0.6588235294117647, green: 0.9372549019607843, blue: 1.0, alpha: 1) // 0xa8efff
            case .blue50:
                return #colorLiteral(red: 0.8823529411764706, green: 0.9647058823529412, blue: 1, alpha: 1) // 0xe1f6ff

            case .red400:
                return #colorLiteral(red: 1.0, green: 0.00784313725490196, blue: 0.06666666666666667, alpha: 1) // 0xff0211
            case .red300:
                return #colorLiteral(red: 1.0, green: 0.403921568627451, blue: 0.4392156862745098, alpha: 1) // 0xff6770
            case .red200:
                return #colorLiteral(red: 1.0, green: 0.6588235294117647, blue: 0.6823529411764706, alpha: 1) // 0xffa8ae
            case .red100:
                return #colorLiteral(red: 1.0, green: 0.9019607843137255, blue: 0.9098039215686274, alpha: 1) // 0xffe6e8
            case .red50:
                return #colorLiteral(red: 1.0, green: 0.9607843137254902, blue: 0.9607843137254902, alpha: 1) // 0xfff5f5

            case .green300:
                return #colorLiteral(red: 0.27450980392156865, green: 0.7450980392156863, blue: 0, alpha: 1) // 0x46be00
            case .green50:
                return #colorLiteral(red: 0.9411764705882353, green: 1.0, blue: 0.9019607843137255, alpha: 1) // 0xf0ffe6
            case .mono600:
                return #colorLiteral(red: 0.13333333333333333, green: 0.13333333333333333, blue: 0.13333333333333333, alpha: 1) // 0x222222
            case .mono500:
                return #colorLiteral(red: 0.5333333333333333, green: 0.5333333333333333, blue: 0.5333333333333333, alpha: 1) // 0x888888
            case .mono400:
                return #colorLiteral(red: 0.7490196078431373, green: 0.7490196078431373, blue: 0.7490196078431373, alpha: 1) // 0xbfbfbf
            case .mono200:
                return #colorLiteral(red: 0.9372549019607843, green: 0.9372549019607843, blue: 0.9372549019607843, alpha: 1) // 0xefefef
            case .mono100:
                return #colorLiteral(red: 0.9803921568627451, green: 0.9803921568627451, blue: 0.9803921568627451, alpha: 1) // 0xfafafa
            case .mono50:
                return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // 0xffffff

            case .shadow:
                return #colorLiteral(red: 0.34901960784313724, green: 0.34901960784313724, blue: 0.34901960784313724, alpha: 1) // 0x595959
            }

        }
    }

    public var rawPalette: [BrandingManager.PaletteOption] {
        return Palette.allCases.map { BrandingManager.PaletteOption(name: $0.rawValue, color: $0.color) }
    }
}
