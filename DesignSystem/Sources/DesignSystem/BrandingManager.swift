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

infix operator ====

public class BrandingManager {

    public static let didChange = "DesignSystem_DidChange"
    public static let contentSizeOverrideKey = "DesignSystem_contentSizeCategory_override"
    public static let contentSizeOverrideValueKey = "DesignSystem_contentSizeCategory_value"

    public enum Color {
        case
        atom(Key),
        brand(Key),
        background(Key),
        text(Key),
        divider(Key)

        public struct Key: Equatable, RawRepresentable {
            public let rawValue: String

            public init(_ value: String) {
                self.rawValue = value
            }

            public init(rawValue: String) {
                self.rawValue = rawValue
            }

            public static func ==(lhs: Key, rhs: Key) -> Bool {
                return lhs.rawValue == rhs.rawValue
            }
        }
    }

    public struct PaletteOption {
        public let name: String
        public let color: UIColor
        
        public init(name: String, color: UIColor) {
            self.name = name
            self.color = color
        }
    }

    public enum Spacing: String, CaseIterable {
        case xxsmall,
        xsmall,
        small,
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

    public struct Typography: CaseIterable, Equatable {

        fileprivate enum Style: String {
            case xxsmall,
            xsmall,
            small,
            medium,
            large,
            xlarge,
            xxlarge
        }

        public enum Modifier: String {
            case strong,
            noAccessibility
        }

        public static func == (lhs: Typography, rhs: Typography) -> Bool {
            return lhs.style == rhs.style
        }

        public static func ==== (lhs: Typography, rhs: Typography) -> Bool {
            guard lhs == rhs else { return false }
            guard lhs.modifiers.count == rhs.modifiers.count else { return false }
            for mod in lhs.modifiers { guard rhs.modifiers.contains(mod) else { return false } }
            return true
        }

        public static let xxsmall = Typography(.xxsmall)
        public static let xsmall = Typography(.xsmall)
        public static let small = Typography(.small)
        public static let medium = Typography(.medium)
        public static let large = Typography(.large)
        public static let xlarge = Typography(.xlarge)
        public static let xxlarge = Typography(.xxlarge)

        public static func xxsmall(_ modifier: Modifier) -> Typography { return Typography(.xxsmall, [modifier]) }
        public static func xsmall(_ modifier: Modifier) -> Typography { return Typography(.xsmall, [modifier]) }
        public static func small(_ modifier: Modifier) -> Typography { return Typography(.small, [modifier]) }
        public static func medium(_ modifier: Modifier) -> Typography { return Typography(.medium, [modifier]) }
        public static func large(_ modifier: Modifier) -> Typography { return Typography(.large, [modifier]) }
        public static func xlarge(_ modifier: Modifier) -> Typography { return Typography(.xlarge, [modifier]) }
        public static func xxlarge(_ modifier: Modifier) -> Typography { return Typography(.xxlarge, [modifier]) }

        public static func xxsmall(_ modifiers: [Modifier]) -> Typography { return Typography(.xxsmall, modifiers) }
        public static func xsmall(_ modifiers: [Modifier]) -> Typography { return Typography(.xsmall, modifiers) }
        public static func small(_ modifiers: [Modifier]) -> Typography { return Typography(.small, modifiers) }
        public static func medium(_ modifiers: [Modifier]) -> Typography { return Typography(.medium, modifiers) }
        public static func large(_ modifiers: [Modifier]) -> Typography { return Typography(.large, modifiers) }
        public static func xlarge(_ modifiers: [Modifier]) -> Typography { return Typography(.xlarge, modifiers) }
        public static func xxlarge(_ modifiers: [Modifier]) -> Typography { return Typography(.xxlarge, modifiers) }

        public static var allCases: [Typography] {
            let basic = [.xxsmall, .xsmall, .small, .medium, large, xlarge, xxlarge]
            let str = basic.map { Typography($0.style, [.strong]) }
            let noAcc = basic.map { Typography($0.style, [.noAccessibility]) }
            let strNoAcc = basic.map { Typography($0.style, [.strong, .noAccessibility]) }
            return basic + str + noAcc + strNoAcc
        }

        private let style: Style
        private var modifiers: [Modifier]

        fileprivate init(_ style: Style, _ modifiers: [Modifier] = []) {
            self.style = style
            self.modifiers = modifiers
        }

        public var name: String {
            var string = style.rawValue
            if modifiers.contains(.strong) { string += " \(Modifier.strong.rawValue)" }
            if modifiers.contains(.noAccessibility) { string += " \(Modifier.noAccessibility.rawValue)" }
            return string
        }

        public var useAccessibility: Bool {
            return !modifiers.contains(.noAccessibility)
        }

        public var isStrong: Bool {
            return modifiers.contains(.strong)
        }

        public var fontSize: CGFloat {
            return BrandingManager.brand.fontSize(for: self)
        }

        // Apple font weights
        // ultraLight, thin, light, regular, medium, semibold, bold, heavy, strong, black
        public var fontWeight: UIFont.Weight {
            return BrandingManager.brand.fontWeight(for: self)
        }

        public var lineHeight: CGFloat {
            return font.lineHeight
        }

        public var font: UIFont {
            let name = BrandingManager.brand.fontName(for: fontWeight)
            let defaultFont: UIFont = .systemFont(ofSize: fontSize, weight: fontWeight)

            guard let fontName = name else { return defaultFont }
            return UIFont(name: fontName, size: fontSize) ?? defaultFont
        }

        public var defaultColor: UIColor {
            return .text()
        }
    }

    public static var dateManager: DateManager {
        return globalDateManager
    }

    public static func set(brand: Brand) {
        
        if let current = currentBrand {
            guard current.id != brand.id else { print("Current brand: \(current.id) id matches: \(brand.id)"); return }
        }
        
        currentBrand = brand
        brand.setAppearance()

        print("Setting Brand:", brand.id)
        if #available(iOS 11.0.0, *), UIApplication.shared.supportsAlternateIcons {
            UIApplication.shared.setAlternateIconName("\(brand.id)-AppIcon", completionHandler: nil)
        } else {
            UIApplication.shared.setAlternateIconName(nil, completionHandler: nil)
        }
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: BrandingManager.didChange), object: nil)
    }

    public static var brand: Brand {
        if let brand = currentBrand { return brand }
        print("BrandingManager: No Brand set - Using DefaultBrand")
        let defaultBrand = DefaultBrand()
        currentBrand = defaultBrand
        return defaultBrand
    }

    public static func subscribeToNotifications() {
        _ = NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: nil, queue: nil) { (_) in
            NotificationCenter.default.post(name: Notification.Name(rawValue: BrandingManager.didChange), object: nil)
        }
    }

    public static var contentSizeCategory: UIContentSizeCategory {
        if UserDefaults.standard.bool(forKey: BrandingManager.contentSizeOverrideKey) {
            return UIContentSizeCategory(rawValue: UserDefaults.standard.string(forKey: BrandingManager.contentSizeOverrideValueKey) ?? "medium")
        }
        return UIApplication.shared.preferredContentSizeCategory
    }
}

public protocol Brand {
    var id: String { get }
    var keyboardAppearance: UIKeyboardAppearance { get }
    var preferredStatusBarStyle: UIStatusBarStyle { get }
    var defaultCellHeight: CGFloat { get }
    func setAppearance()
    func image(for key: UIImage.Key) -> UIImage?
    func value(for spacing: BrandingManager.Spacing) -> CGFloat
    func value(for size: BrandingManager.IconSize) -> CGSize
    func value(for color: BrandingManager.Color) -> UIColor
    func fontName(for fontWeight: UIFont.Weight) -> String?
    func fontSize(for typography: BrandingManager.Typography) -> CGFloat
    func fontWeight(for typography: BrandingManager.Typography) -> UIFont.Weight
    var rawPalette: [BrandingManager.PaletteOption] { get }
}

public extension CGFloat { // Spacing and size

    static var xxsmall: CGFloat     { return BrandingManager.brand.value(for: .xxsmall) }
    static var xsmall: CGFloat      { return BrandingManager.brand.value(for: .xsmall) }
    static var small: CGFloat       { return BrandingManager.brand.value(for: .small) }
    static var medium: CGFloat      { return BrandingManager.brand.value(for: .medium) }
    static var large: CGFloat       { return BrandingManager.brand.value(for: .large) }
    static var xlarge: CGFloat      { return BrandingManager.brand.value(for: .xlarge) }
    static var xxlarge: CGFloat     { return BrandingManager.brand.value(for: .xxlarge) }
    static var xxxlarge: CGFloat    { return BrandingManager.brand.value(for: .xxxlarge) }

    static var keyline: CGFloat     { return BrandingManager.brand.value(for: .keyline) }
    static var divider: CGFloat     { return BrandingManager.brand.value(for: .divider) }
}

public extension UIImage {

    static func image(_ key: Key) -> UIImage? {
        return BrandingManager.brand.image(for: key)
    }

    struct Key: Equatable, RawRepresentable {
        public let rawValue: String

        public init(_ value: String) {
            self.rawValue = value
        }

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public static func ==(lhs: Key, rhs: Key) -> Bool {
            return lhs.rawValue == rhs.rawValue
        }
    }
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

    static func atom(_ key: BrandingManager.Color.Key = BrandingManager.Color.Key("")) -> UIColor {
        return BrandingManager.brand.value(for: .atom(key))
    }

    static func brand(_ key: BrandingManager.Color.Key = BrandingManager.Color.Key("")) -> UIColor {
        return BrandingManager.brand.value(for: .brand(key))
    }

    static func background(_ key: BrandingManager.Color.Key = BrandingManager.Color.Key("")) -> UIColor {
        return BrandingManager.brand.value(for: .background(key))
    }

    static func text(_ key: BrandingManager.Color.Key = BrandingManager.Color.Key("")) -> UIColor {
        return BrandingManager.brand.value(for: .text(key))
    }

    static func divider(_ key: BrandingManager.Color.Key = BrandingManager.Color.Key("")) -> UIColor {
        return BrandingManager.brand.value(for: .divider(key))
    }
}

public extension UIStatusBarStyle {
    static var brand: UIStatusBarStyle { return BrandingManager.brand.preferredStatusBarStyle }
}
