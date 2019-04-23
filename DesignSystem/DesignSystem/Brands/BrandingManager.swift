//
//  BrandingManager.swift
//  Mercari
//
//  Created by Anthony Smith on 28/08/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit

// Brand, Spacing, Typography, Colour
// Convienience for accessing the raw style level of the DesignSystem

private var currentBrand: Brand?
private var globalDateManager = DateManager()

public struct BrandingManager {

    public static let didChange = "DesignSystem_DidChange"

    public static let contentSizeOverrideKey = "DesignSystem_contentSizeCategory_override"
    public static let contentSizeOverrideValueKey = "DesignSystem_contentSizeCategory_value"
    private static let brandKey = "DesignSystem_BrandKey"
    private static let darkModeKey = "DesignSystem_DarkMode"

    private static var brandId: BrandUid { return BrandingManager.BrandUid.box }

    public enum Color {

        case brand(BrandColor),
        background(BackgroundColor),
        text(TextColor),
        divider(DividerColor),

        disclosure,
        refreshControl,
        navigationShadow,
        shadow,
        sliderPositiveTint,
        sliderNegativeTint

        public enum DividerColor {
            case primary, secondary, light, accent
        }

        public enum BrandColor {
            case primary, primaryAccent, secondary, tertiary
        }

        public enum ButtonColor {
            case primary, primaryAccent, secondary, disabled, attention
        }

        public enum BackgroundColor {
            case primary, secondary, tertiary, cell, cellSelected, navigationBar, accent, attention, information, light, layerDark, layerMiddle, layerLight
        }

        public enum TextColor {
            case primary, title, information, light, dark, hint, link, placeholder, chat, chatUser, disabled
        }
    }

    public struct PaletteOption {
        public let name: String
        public let color: UIColor
    }

    public enum Spacing: String, CaseIterable {
        case xxsmall,
        xsmall,
        small,
        `default`,
        medium,
        large,
        xlarge,
        xxlarge,
        xxxlarge,
        keyline,
        divider
    }

    public enum IconSize: String, CaseIterable {
        case xsmall,
        small,
        medium,
        large,
        xlarge,
        xxlarge
    }

    public enum Typography: String, CaseIterable {

        case xxlarge,
        xlarge,
        large,
        medium,
        small,
        xsmall,
        xxsmall,
        xxlargeStrong,
        xlargeStrong,
        largeStrong,
        mediumStrong,
        smallStrong,
        xsmallStrong,
        xxsmallStrong,

        xxlargeNoAccessibility,
        xlargeNoAccessibility,
        largeNoAccessibility,
        mediumNoAccessibility,
        smallNoAccessibility,
        xsmallNoAccessibility,
        xxsmallNoAccessibility,
        xxlargeStrongNoAccessibility,
        xlargeStrongNoAccessibility,
        largeStrongNoAccessibility,
        mediumStrongNoAccessibility,
        smallStrongNoAccessibility,
        xsmallStrongNoAccessibility,
        xxsmallStrongNoAccessibility

        public var fontSize: CGFloat {
            return BrandingManager.brand.fontSize(for: self, overrideAdjustment: rawValue.contains("NoAccessibility"))
        }

        public var fontWeight: UIFont.Weight {
            return BrandingManager.brand.fontWeight(for: self)
        }

        public var lineHeight: CGFloat {
            return fontSize + 8.0
        }

        public var font: UIFont {
            let name = BrandingManager.brand.fontName(for: fontWeight)
            let defaultFont: UIFont = .systemFont(ofSize: fontSize, weight: fontWeight)

            guard let fontName = name else { return defaultFont }
            return UIFont(name: fontName, size: fontSize) ?? defaultFont
        }

        public var defaultColor: UIColor {
            return BrandingManager.brand.defaultFontColor(for: self)
        }
    }

    public static var dateManager: DateManager {
        return globalDateManager
    }

    public static var brand: Brand {

        if let brand = currentBrand { return brand }

        let brand: Brand

        switch brandId {
        case .box:
            brand = BoxBrand()
        case .hex:
            brand = HexBrand()
        }

        if #available(iOS 11.0.0, *), UIApplication.shared.supportsAlternateIcons {
            UIApplication.shared.setAlternateIconName("\(brand.uid)-AppIcon", completionHandler: nil)
        }

        currentBrand = brand
        return brand
    }

    public static func subscribeToNotifications() {
        _ = NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: nil, queue: nil) { (_) in
            NotificationCenter.default.post(name: Notification.Name(rawValue: BrandingManager.didChange), object: nil)
        }
    }

    public static func applyBrand(with uid: BrandingManager.BrandUid) {

        guard brand.uid != uid else { return }
        currentBrand = nil
        UserDefaults.standard.set(uid.rawValue, forKey: brandKey)
        NotificationCenter.default.post(name: Notification.Name(rawValue: BrandingManager.didChange), object: nil)
    }

    public static var contentSizeCategory: UIContentSizeCategory {
        if UserDefaults.standard.bool(forKey: BrandingManager.contentSizeOverrideKey) {
            return UIContentSizeCategory(rawValue: UserDefaults.standard.string(forKey: BrandingManager.contentSizeOverrideValueKey) ?? "medium")
        }
        return UIApplication.shared.preferredContentSizeCategory
    }
}

public protocol Brand {
    var uid: BrandingManager.BrandUid { get }
    var keyboardAppearance: UIKeyboardAppearance { get }
    func value(for spacing: BrandingManager.Spacing) -> CGFloat
    func value(for size: BrandingManager.IconSize) -> CGSize
    func value(for color: BrandingManager.Color) -> UIColor
    func fontName(for fontWeight: UIFont.Weight) -> String?
    func fontSize(for typography: BrandingManager.Typography, overrideAdjustment: Bool) -> CGFloat
    func fontWeight(for typography: BrandingManager.Typography) -> UIFont.Weight
    func defaultFontColor(for typography: BrandingManager.Typography) -> UIColor
    var rawPalette: [BrandingManager.PaletteOption] { get }
}

public extension BrandingManager {

    static var isBoxBrand: Bool {
        return BrandingManager.brand.uid == .box
    }

    static var isHexBrand: Bool {
        return BrandingManager.brand.uid == .hex
    }

    enum BrandUid: String {
        case hex, box
    }
}

public extension CGFloat { // Spacing and size

    static var xxsmall: CGFloat     { return BrandingManager.brand.value(for: .xxsmall) }
    static var xsmall: CGFloat      { return BrandingManager.brand.value(for: .xsmall) }
    static var small: CGFloat       { return BrandingManager.brand.value(for: .small) }
    static var `default`: CGFloat   { return BrandingManager.brand.value(for: .default) }
    static var medium: CGFloat      { return BrandingManager.brand.value(for: .medium) }
    static var large: CGFloat       { return BrandingManager.brand.value(for: .large) }
    static var xlarge: CGFloat      { return BrandingManager.brand.value(for: .xlarge) }
    static var xxlarge: CGFloat     { return BrandingManager.brand.value(for: .xxlarge) }
    static var xxxlarge: CGFloat    { return BrandingManager.brand.value(for: .xxxlarge) }

    static var keyline: CGFloat     { return BrandingManager.brand.value(for: .keyline) }
    static var divider: CGFloat     { return BrandingManager.brand.value(for: .divider) }
}

public extension CGSize { // IconSize

    static var xsmallIcon: CGSize      { return BrandingManager.brand.value(for: .xsmall) }
    static var smallIcon: CGSize       { return BrandingManager.brand.value(for: .small) }
    static var mediumIcon: CGSize      { return BrandingManager.brand.value(for: .medium) }
    static var largeIcon: CGSize       { return BrandingManager.brand.value(for: .large) }
    static var xlargeIcon: CGSize      { return BrandingManager.brand.value(for: .xlarge) }
    static var xxlargeIcon: CGSize     { return BrandingManager.brand.value(for: .xxlarge) }
}

public extension UIColor {

    static func atom(_ colorType: BrandingManager.Color) -> UIColor {
        return BrandingManager.brand.value(for: colorType)
    }

    static func brand(_ colorType: BrandingManager.Color.BrandColor = .primary) -> UIColor {
        return BrandingManager.brand.value(for: .brand(colorType))
    }

    static func background(_ colorType: BrandingManager.Color.BackgroundColor = .primary) -> UIColor {
        return BrandingManager.brand.value(for: .background(colorType))
    }

    static func text(_ colorType: BrandingManager.Color.TextColor = .primary) -> UIColor {
        return BrandingManager.brand.value(for: .text(colorType))
    }

    static func divider(_ colorType: BrandingManager.Color.DividerColor = .primary) -> UIColor {
        return BrandingManager.brand.value(for: .divider(colorType))
    }

    // MARK: - Inherited / Universal

    static var facebookBlue: UIColor { return #colorLiteral(red: 0.26, green: 0.40, blue: 0.70, alpha: 1.0) } //0x4267b2
    static var paypalBlue: UIColor { return #colorLiteral(red: 0.00, green: 0.20, blue: 0.54, alpha: 1.0) } //0x00328a
}
