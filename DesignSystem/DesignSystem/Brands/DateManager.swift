//
//  DateManager.swift
//  Mercari
//
//  Created by Anthony Smith on 02/04/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation

private let oneMinute: TimeInterval = 60.0
private let twoMinutes = oneMinute * 2.0
private let oneHour = oneMinute * 60.0
private let twoHours = oneHour * 2.0
private let oneDay = oneHour * 24.0
private let twoDays = oneDay * 2.0
private let oneMonth = oneDay * 30.0
private let twoMonths = oneMonth * 2.0
private let sixMonths = oneMonth * 6.0

// After we spoke about having a single DateFormatter as they are incredibly slow..
// I'm wondering how other than a singleton you might create a solution here? Or is a Singleton the only option? - Anthony

public enum DateStyle {
    case detailed, medium, fuzzy
}

public protocol BrandDate {
    var detailedFormatter: DateFormatter { get }
    var mediumFormatter: DateFormatter { get }
    func fuzzyString(from date: Date) -> String
}

public final class DateManager {

    // TODO: subscribe to NSLocale.currentLocaleDidChangeNotification to reset on Locale change

    public func string(from date: Date?, style: DateStyle = .medium, placeholder: String = "") -> String {

        guard let date = date else { return placeholder }

        if let brand = BrandingManager.brand as? BrandDate {
            switch style {
            case .detailed:
                return brand.detailedFormatter.string(from: date)
            case .medium:
                return brand.mediumFormatter.string(from: date)
            case .fuzzy:
                return brand.fuzzyString(from: date)
            }
        }

        switch style {
        case .detailed:
            return defaultDetailedFormatter.string(from: date)
        case .medium:
            return defaultMediumFormatter.string(from: date)
        case .fuzzy:
            return fuzzyString(from: date)
        }
    }

    private func fuzzyString(from date: Date) -> String {

        let timeSinceNow = -(date.timeIntervalSinceNow)
        guard timeSinceNow >= 0 else { Assert("Date is in the future"); return "" }

        // TODO: add localized pluralisation rules

        switch timeSinceNow {
        case 0..<oneMinute:
            return "Just now"
        case oneMinute..<twoMinutes:
            return "1 minute ago"
        case twoMinutes..<oneHour:
            return String(format: "%i minutes ago", Int(timeSinceNow / oneMinute))
        case oneHour..<twoHours:
            return "1 hour ago"
        case twoHours..<oneDay:
            return String(format: "%i hours ago", Int(timeSinceNow / oneHour))
        case oneDay..<twoDays:
            return "1 day ago"
        case twoDays..<oneMonth:
            return String(format: "%i days ago", Int(timeSinceNow / oneDay))
        case oneMonth..<twoMonths:
            return "1 month ago"
        case twoMonths..<sixMonths:
            return String(format: "%i months ago", Int(timeSinceNow / oneMonth))
        default:
            return string(from: date)
        }
    }

    // MARK: - Properties

    private lazy var defaultDetailedFormatter: DateFormatter = {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"

        return formatter
    }()

    private lazy var defaultMediumFormatter: DateFormatter = {

        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.timeZone = .current

        return formatter
    }()
}
