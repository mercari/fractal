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

private var notificationObject: NSObjectProtocol?
private var currentBrand: Brand?
private var globalDateManager = DateManager()

infix operator ====

public protocol Brand {

    var id: String { get }
    var keyboardAppearance: UIKeyboardAppearance { get }
    var preferredStatusBarStyle: UIStatusBarStyle { get }
    var defaultCellHeight: CGFloat { get }
    var resourceBundle: Bundle? { get }

    func imageName(for key: UIImage.Key) -> String?

    // Spacing and Sizing
    func value(for spacing: BrandingManager.Spacing) -> CGFloat
    func value(for size: BrandingManager.IconSize) -> CGSize

    // Typograhy
    func fontName(for typography: BrandingManager.Typography) -> String?
    func fontWeight(for typography: BrandingManager.Typography) -> UIFont.Weight
    func fontSize(for typography: BrandingManager.Typography) -> CGFloat

    // Colors
    func atomColor(for key: UIColor.Key) -> UIColor
    func brandColor(for key: UIColor.Key) -> UIColor
    func backgroundColor(for key: UIColor.Key) -> UIColor
    func textColor(for key: UIColor.Key) -> UIColor
}

protocol BrandTest {
    var rawPalette: [BrandingManager.PaletteOption] { get }
    var allTypographyCases: [BrandingManager.Typography] { get }
}

public extension UIColor {
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

public class BrandingManager {

    public static let didChange = "BrandingManager_BrandDidChange"
    public static let contentSizeOverrideKey = "BrandingManager_contentSizeCategory_override"
    public static let contentSizeOverrideValueKey = "BrandingManager_contentSizeCategory_value"

    public struct PaletteOption {
        public let name: String
        public let color: UIColor
        
        public init(name: String, color: UIColor) {
            self.name = name
            self.color = color
        }
    }

    //TODO: change to keys, and use cornerRadius and other spacing types
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
        padding,
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

    //TODO: change to keys
    public struct Typography: CaseIterable, Equatable {

        public enum Style: String {
            case xxxsmall,
            xxsmall,
            xsmall,
            small,
            medium,
            large,
            xlarge,
            xxlarge,
            xxxlarge
        }

        // Style + Modifier determines the actual font properties under the hood in your brand

        public let style: Style
        public var modifiers: [Modifier]

        public struct Modifier: Equatable, RawRepresentable {
            public let rawValue: String

            public init(_ value: String) {
                self.rawValue = value
            }

            public init(rawValue: String) {
                self.rawValue = rawValue
            }

            public static func ==(lhs: Modifier, rhs: Modifier) -> Bool {
                return lhs.rawValue == rhs.rawValue
            }

            public static let strong = Modifier("strong")
            public static let noAccessibility = Modifier("noAccessibility")
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

        public static var allCases: [Typography] {
            let basicCases = [.xxsmall, .xsmall, .small, .medium, large, xlarge, xxlarge]
            return basicCases
        }

        public init(_ style: Style, _ modifiers: [Modifier] = []) {
            self.style = style
            self.modifiers = modifiers
        }

        public var name: String {
            var string = style.rawValue
            if modifiers.contains(.strong) { string += " \(Modifier.strong.rawValue)" }
            if modifiers.contains(.noAccessibility) { string += " \(Modifier.noAccessibility.rawValue)" }
            return string
        }

        public var font: UIFont {
            let name = BrandingManager.brand.fontName(for: self)
            let defaultFont: UIFont = .systemFont(ofSize: fontSize, weight: fontWeight)
            guard let fontName = name else { return defaultFont }
            return UIFont(name: fontName, size: fontSize) ?? defaultFont
        }

        // Apple font weights
        // ultraLight, thin, light, regular, medium, semibold, bold, heavy, strong, black
        public var fontWeight: UIFont.Weight {
            return BrandingManager.brand.fontWeight(for: self)
        }

        public var useAccessibility: Bool { return !modifiers.contains(.noAccessibility) }

        public var isStrong: Bool { return modifiers.contains(.strong) }

        public var fontSize: CGFloat { return BrandingManager.brand.fontSize(for: self) }

        public var lineHeight: CGFloat { return font.lineHeight }

        public var defaultColor: UIColor { return .text } // TODO: put inside brand
    }

    public static func set(brand: Brand) {
        
        if let current = currentBrand {
            guard current.id != brand.id else { print("Current brand: \(current.id) id matches: \(brand.id)"); return }
        }
        
        currentBrand = brand
        print("Setting Brand:", brand.id)
        NotificationCenter.default.post(name: Notification.Name(rawValue: BrandingManager.didChange), object: nil)
    }

    public static var brand: Brand {
        if let brand = currentBrand { return brand }
        print("BrandingManager: No Brand set - Using DefaultBrand")
        let defaultBrand = DefaultBrand()
        currentBrand = defaultBrand
        return defaultBrand
    }

    public static var dateManager: DateManager {
        return globalDateManager
    }

    public static func subscribeToNotifications() {
        notificationObject = NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: nil, queue: nil) { (_) in
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

public extension BrandingManager.Typography {

    static let xxsmall = BrandingManager.Typography(.xxsmall)
    static let xsmall = BrandingManager.Typography(.xsmall)
    static let small = BrandingManager.Typography(.small)
    static let medium = BrandingManager.Typography(.medium)
    static let large = BrandingManager.Typography(.large)
    static let xlarge = BrandingManager.Typography(.xlarge)
    static let xxlarge = BrandingManager.Typography(.xxlarge)

    static func xxsmall(_ modifier: Modifier) -> BrandingManager.Typography { return BrandingManager.Typography(.xxsmall, [modifier]) }
    static func xsmall(_ modifier: Modifier)  -> BrandingManager.Typography { return BrandingManager.Typography(.xsmall, [modifier]) }
    static func small(_ modifier: Modifier)   -> BrandingManager.Typography { return BrandingManager.Typography(.small, [modifier]) }
    static func medium(_ modifier: Modifier)  -> BrandingManager.Typography { return BrandingManager.Typography(.medium, [modifier]) }
    static func large(_ modifier: Modifier)   -> BrandingManager.Typography { return BrandingManager.Typography(.large, [modifier]) }
    static func xlarge(_ modifier: Modifier)  -> BrandingManager.Typography { return BrandingManager.Typography(.xlarge, [modifier]) }
    static func xxlarge(_ modifier: Modifier) -> BrandingManager.Typography { return BrandingManager.Typography(.xxlarge, [modifier]) }

    static func xxsmall(_ modifiers: [Modifier]) -> BrandingManager.Typography { return BrandingManager.Typography(.xxsmall, modifiers) }
    static func xsmall(_ modifiers: [Modifier])  -> BrandingManager.Typography { return BrandingManager.Typography(.xsmall, modifiers) }
    static func small(_ modifiers: [Modifier])   -> BrandingManager.Typography { return BrandingManager.Typography(.small, modifiers) }
    static func medium(_ modifiers: [Modifier])  -> BrandingManager.Typography { return BrandingManager.Typography(.medium, modifiers) }
    static func large(_ modifiers: [Modifier])   -> BrandingManager.Typography { return BrandingManager.Typography(.large, modifiers) }
    static func xlarge(_ modifiers: [Modifier])  -> BrandingManager.Typography { return BrandingManager.Typography(.xlarge, modifiers) }
    static func xxlarge(_ modifiers: [Modifier]) -> BrandingManager.Typography { return BrandingManager.Typography(.xxlarge, modifiers) }
}

public extension CGFloat { // Spacing and size

    static var xxsmall:  CGFloat { return BrandingManager.brand.value(for: .xxsmall) }
    static var xsmall:   CGFloat { return BrandingManager.brand.value(for: .xsmall) }
    static var small:    CGFloat { return BrandingManager.brand.value(for: .small) }
    static var medium:   CGFloat { return BrandingManager.brand.value(for: .medium) }
    static var large:    CGFloat { return BrandingManager.brand.value(for: .large) }
    static var xlarge:   CGFloat { return BrandingManager.brand.value(for: .xlarge) }
    static var xxlarge:  CGFloat { return BrandingManager.brand.value(for: .xxlarge) }
    static var xxxlarge: CGFloat { return BrandingManager.brand.value(for: .xxxlarge) }

    static var padding:  CGFloat { return BrandingManager.brand.value(for: .padding) }
    static var keyline:  CGFloat { return BrandingManager.brand.value(for: .keyline) }
    static var divider:  CGFloat { return BrandingManager.brand.value(for: .divider) }
}

public extension UIImageView {
    convenience init(_ key: UIImage.Key, in bundle: Bundle? = nil, renderingMode: UIImage.RenderingMode = .alwaysOriginal) {
        self.init(image: UIImage.with(key, in: bundle)?.withRenderingMode(renderingMode))
    }
}

public extension UIImage {

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

    static func with(_ key: Key, in bundle: Bundle? = nil) -> UIImage? {
        guard let name = BrandingManager.brand.imageName(for: key) else { return nil }

        if let bundle = bundle, let image = UIImage(named: name, in: bundle, compatibleWith: nil) {
            return image
        }

        if let bundle = BrandingManager.brand.resourceBundle, let image = UIImage(named: name, in: bundle, compatibleWith: nil) {
            return image
        }

        if let image = UIImage(named: name, in: .main, compatibleWith: nil) {
            return image
        }

        if let image = UIImage(named: name, in: Bundle(for: BrandingManager.self), compatibleWith: nil) {
            return image
        }

        print("Failed to find \(key.rawValue) in any bundle")
        return nil
    }
}

public extension CGSize { // IconSize

    static var xsmallIcon:  CGSize { return BrandingManager.brand.value(for: .xsmall) }
    static var smallIcon:   CGSize { return BrandingManager.brand.value(for: .small) }
    static var mediumIcon:  CGSize { return BrandingManager.brand.value(for: .medium) }
    static var largeIcon:   CGSize { return BrandingManager.brand.value(for: .large) }
    static var xlargeIcon:  CGSize { return BrandingManager.brand.value(for: .xlarge) }
    static var xxlargeIcon: CGSize { return BrandingManager.brand.value(for: .xxlarge) }
}

public extension UIColor {

    static var atom:       UIColor { return .atom(.primary) }
    static var brand:      UIColor { return .brand(.primary) }
    static var background: UIColor { return .background(.primary) }
    static var text:       UIColor { return .text(.primary) }

    static func atom(_ key: UIColor.Key = .primary) -> UIColor {
        return BrandingManager.brand.atomColor(for: key)
    }

    static func brand(_ key: UIColor.Key = .primary) -> UIColor {
        return BrandingManager.brand.brandColor(for: key)
    }

    static func background(_ key: UIColor.Key = .primary) -> UIColor {
        return BrandingManager.brand.backgroundColor(for: key)
    }

    static func text(_ key: UIColor.Key = .primary) -> UIColor {
        return BrandingManager.brand.textColor(for: key)
    }
}
