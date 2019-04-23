//
//  MercariBrands.swift
//  DesignSample
//
//  Created by Anthony Smith on 03/10/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit

public class BoxBrand: Brand { // Old brand

    public var uid: BrandingManager.BrandUid { return .box }

    public var keyboardAppearance: UIKeyboardAppearance { return .light }

    public func value(for spacing: BrandingManager.Spacing) -> CGFloat {
        switch spacing {
        case .divider:
            return 1.0
        case .xxsmall:
            return 2.0
        case .xsmall:
            return 5.0
        case .small:
            return 10.0
        case .default, .keyline:
            return 15.0
        case .medium:
            return 20.0
        case .large:
            return 25.0
        case .xlarge:
            return 30.0
        case .xxlarge:
            return 40.0
        case .xxxlarge:
            return 50.0
        }
    }

    public func value(for size: BrandingManager.IconSize) -> CGSize {

        let value: CGFloat

        switch size {
        case .xsmall:
            value = 5.0
        case .small:
            value = 10.0
        case .medium:
            value = 15.0
        case .large:
            value = 20.0
        case .xlarge:
            value = 30.0
        case .xxlarge:
            value = 40.0
        }

        return CGSize (width: value, height: value)
    }

    public func fontName(for fontWeight: UIFont.Weight) -> String? {
        return nil
    }

    public func fontSize(for typography: BrandingManager.Typography, overrideAdjustment: Bool) -> CGFloat {
        switch typography {
        case .xxlarge, .xxlargeStrong, .xxlargeNoAccessibility, .xxlargeStrongNoAccessibility:
            return 17.0
        case .xlarge, .xlargeStrong, .xlargeNoAccessibility, .xlargeStrongNoAccessibility:
            return 15.0
        case .large, .largeStrong, .largeNoAccessibility, .largeStrongNoAccessibility,
             .medium, .mediumStrong, .mediumNoAccessibility, .mediumStrongNoAccessibility:
            return 14.0
        case .small, .smallStrong, .smallNoAccessibility, .smallStrongNoAccessibility:
            return 13.0
        case .xsmall, .xsmallStrong, .xsmallNoAccessibility, .xsmallStrongNoAccessibility:
            return 12.0
        case .xxsmall, .xxsmallStrong, .xxsmallNoAccessibility, .xxsmallStrongNoAccessibility:
            return 10.0
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
        return .black
    }

    public enum Palette {

        enum Brand {
            static var blue: UIColor { return #colorLiteral(red: 0, green: 0.6274509804, blue: 0.9137254902, alpha: 1) } // srgb #00a0e9
            static var red: UIColor { return #colorLiteral(red: 0.8352941176, green: 0.2470588235, blue: 0.2588235294, alpha: 1) } // srgb #d53f42
        }

        enum Text {
            static var main: UIColor { return #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1) } // srgb #333333
            static var sub: UIColor { return #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1) } // srgb #666666
            static var date: UIColor { return #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1) } // srgb #999999
            static var bg: UIColor { return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) } // srgb #ffffff
        }

        enum Link {
            static var normal: UIColor { return Brand.blue } // srgb #00a0e9
            static var red: UIColor { return Brand.red } // srgb #d53f42
        }

        enum Button {
            static var red: UIColor { return #colorLiteral(red: 0.8901960784, green: 0.2745098039, blue: 0.2392156863, alpha: 1) } // srgb #e3463d
            static var gray: UIColor { return #colorLiteral(red: 0.8274509804, green: 0.8274509804, blue: 0.8274509804, alpha: 1) } // srgb #d3d3d3
            static var bg: UIColor { return #colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1) } // srgb #e9e9e9
            static var toggle: UIColor { return #colorLiteral(red: 0.6637810469, green: 0.6583601236, blue: 0.6758933663, alpha: 1) } // srgb a9a8ac
        }

        enum Background {
            static var light: UIColor { return #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1) } // srgb #ffffff
            static var normal: UIColor { return #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1) } // srgb #efefef
            static var developer: UIColor { return #colorLiteral(red: 0.0981996581, green: 0.6806125641, blue: 0.7170791626, alpha: 1) } // srgb #333333
            static var gray: UIColor { return #colorLiteral(red: 0.8509803921, green: 0.8509803921, blue: 0.8509803921, alpha: 1) } // srgb #D9D9D9
        }

        enum Line {
            static var normal: UIColor { return #colorLiteral(red: 0.9000526667, green: 0.9000526667, blue: 0.9000526667, alpha: 1) } // srgb #d5d5d5
        }

        enum Placeholder {
            static var normal: UIColor { return #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.8078431373, alpha: 1) } // srgb #c8c8ce
            static var highlight: UIColor { return #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1) } // srgb #B3B3B3
        }

        enum LivePlaceholder {
            static var normal: UIColor { return UIColor(white: 0.972, alpha: 1.0) } // srgb #f8f8f8
        }

        enum Shadow {
            static var normal: UIColor { return #colorLiteral(red: 0.34765625, green: 0.34765625, blue: 0.34765625, alpha: 1) } // srgb #595959
            static var dark: UIColor { return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) } // srgb #000000
        }
    }

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
            return Palette.Text.sub
        case .navigationShadow:
            return Palette.Line.normal
        case .disclosure:
            return Palette.Line.normal
        case .shadow:
            return Palette.Shadow.normal
        case .sliderPositiveTint:
            return Palette.Brand.blue
        case .sliderNegativeTint:
            return Palette.Line.normal
        }
    }

    private func divider(_ type: BrandingManager.Color.DividerColor) -> UIColor {
        return Palette.Line.normal
    }

    private func brand(_ type: BrandingManager.Color.BrandColor) -> UIColor {
        return Palette.Brand.red
    }

    private func background(_ type: BrandingManager.Color.BackgroundColor) -> UIColor {
        switch type {
        case .light, .navigationBar, .primary, .secondary, .tertiary:
            return Palette.Background.normal
        case .cell:
            return Palette.Background.light
        case .attention:
            return Palette.Brand.red
        case .information, .accent:
            return Palette.Brand.blue
        case .cellSelected:
            return UIColor(white: 0.0, alpha: 0.05)
        case .layerDark:
            return UIColor(white: 0.0, alpha: 0.6)
        case .layerMiddle:
            return UIColor(white: 0.0, alpha: 0.4)
        case .layerLight:
            return UIColor(white: 0.0, alpha: 0.2)
        }
    }

    private func text(_ type: BrandingManager.Color.TextColor) -> UIColor {
        switch type {
        case .primary, .title, .dark:
            return Palette.Text.main
        case .information:
            return Palette.Text.date
        case .light, .chat, .chatUser:
            return Palette.Text.bg
        case .link:
            return Palette.Link.normal
        case .hint, .placeholder:
            return Palette.Text.sub
        case .disabled:
            return Palette.Text.date
        }
    }

    public var rawPalette: [BrandingManager.PaletteOption] {
        return []
    }
}
