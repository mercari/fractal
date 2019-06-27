//
//  UIView+Pin.swift
//  DesignSystem
//
//  Created by Anthony Smith on 03/09/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    // MARK: - Pinning Functions

    @discardableResult public func pin(to view: UIView, _ pins: [Pin] = [.leading, .top, .trailing, .bottom]) -> [NSLayoutConstraint] {

        guard superview != nil else { PinAssert("Pin: \(String(describing: self)) - No superview set"); return [] }
        translatesAutoresizingMaskIntoConstraints = false
        let newConstraints = pins.constraints(pinning: self, toItem: view)
        activateIfNeeded(newConstraints)
        return newConstraints
    }

    @discardableResult public func pin(_ pins: [Pin]) -> [NSLayoutConstraint] {

        translatesAutoresizingMaskIntoConstraints = false
        let needsViewPins = pins.filter { $0.type.needsView }
        if needsViewPins.count > 0 {
            PinAssert("\(String(describing: self)) - func pin(_ pins: [Pin]) is a function for pinning width and height constants only, please use func pin(to view: UIView...")
        }
        let newConstraints = pins.filter { !$0.type.needsView }.constraints(pinning: self)
        activateIfNeeded(newConstraints)
        return newConstraints
    }

    @discardableResult public func pin(to options: [UIView: [Pin]]) -> [UIView: [NSLayoutConstraint]] {

        guard superview != nil else { PinAssert("Pin: \(String(describing: self)) - No superview set"); return [:] }
        translatesAutoresizingMaskIntoConstraints = false
        var constraints = [UIView: [LayoutConstraint]]()
        for view in options.keys {
            guard let pins = options[view] else { continue }
            let newConstraints = pins.constraints(pinning: self, toItem: view)
            constraints[view] = newConstraints
            activateIfNeeded(newConstraints)
        }
        
        return constraints
    }
}

public struct Pin {

    public enum Option {
        case multiplier(CGFloat), relation(NSLayoutConstraint.Relation), priority(UILayoutPriority), isActive(Bool)
    }

    // It's a little messy to have both static variables and static functions
    // but it means users can remove empty brackets and it's easier to read list of available pins

    // MARK: - Static Variables

    public static var left: Pin { return .left() }
    public static var right: Pin { return .right() }
    public static var top: Pin { return .top() }
    public static var bottom: Pin { return .bottom() }
    public static var leading: Pin { return .leading() }
    public static var trailing: Pin { return .trailing() }
    public static var width: Pin { return .width() }
    public static var height: Pin { return .height() }
    public static var centerX: Pin { return .centerX() }
    public static var centerY: Pin { return .centerY() }
    public static var lastBaseline: Pin { return .lastBaseline() }
    public static var firstBaseline: Pin { return .firstBaseline() }
    public static var leftMargin: Pin { return .leftMargin() }
    public static var rightMargin: Pin { return .rightMargin() }
    public static var topMargin: Pin { return .topMargin() }
    public static var bottomMargin: Pin { return .bottomMargin() }
    public static var leadingMargin: Pin { return .leadingMargin() }
    public static var trailingMargin: Pin { return .trailingMargin() }
    public static var centerXWithinMargins: Pin { return .centerXWithinMargins() }
    public static var centerYWithinMargins: Pin { return .centerYWithinMargins() }

    public static var below: Pin { return .below() }
    public static var above: Pin { return .above() }
    public static var leftOf: Pin { return .leftOf() }
    public static var rightOf: Pin { return .rightOf() }

    public static var heightToWidth: Pin { return .heightToWidth() }
    public static var widthToHeight: Pin { return .heightToWidth() }

    public static var none: Pin { return Pin(.none) }

    // MARK: - Static Functions

    public static func custom(_ attribute1: NSLayoutConstraint.Attribute, to attribute2: NSLayoutConstraint.Attribute, constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.custom(attribute1, attribute2), constant: constant, options: options)
    }

    public static func left(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.left, constant: constant, options: options)
    }

    public static func right(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.right, constant: constant, options: options)
    }

    public static func top(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.top, constant: constant, options: options)
    }

    public static func bottom(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.bottom, constant: constant, options: options)
    }

    public static func leading(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.leading, constant: constant, options: options)
    }

    public static func trailing(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.trailing, constant: constant, options: options)
    }

    public static func width(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.width(false), constant: constant, options: options)
    }

    public static func height(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.height(false), constant: constant, options: options)
    }

    public static func width(asConstant: CGFloat, options: [Option] = []) -> Pin {
        return Pin(.width(true), constant: asConstant, options: options)
    }

    public static func height(asConstant: CGFloat, options: [Option] = []) -> Pin {
        return Pin(.height(true), constant: asConstant, options: options)
    }

    public static func centerX(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.centerX, constant: constant, options: options)
    }

    public static func centerY(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.centerY, constant: constant, options: options)
    }

    public static func lastBaseline(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.lastBaseline, constant: constant, options: options)
    }

    public static func firstBaseline(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.firstBaseline, constant: constant, options: options)
    }

    public static func leftMargin(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.leftMargin, constant: constant, options: options)
    }

    public static func rightMargin(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.rightMargin, constant: constant, options: options)
    }

    public static func topMargin(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.topMargin, constant: constant, options: options)
    }

    public static func bottomMargin(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.bottomMargin, constant: constant, options: options)
    }

    public static func leadingMargin(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.leadingMargin, constant: constant, options: options)
    }

    public static func trailingMargin(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.trailingMargin, constant: constant, options: options)
    }

    public static func centerXWithinMargins(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.centerXWithinMargins, constant: constant, options: options)
    }

    public static func centerYWithinMargins(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.centerYWithinMargins, constant: constant, options: options)
    }

    public static func below(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.below, constant: constant, options: options)
    }

    public static func above(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.above, constant: constant, options: options)
    }

    public static func leftOf(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.leftOf, constant: constant, options: options)
    }

    public static func rightOf(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.rightOf, constant: constant, options: options)
    }

    public static func heightToWidth(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.heightToWidth, constant: constant, options: options)
    }

    public static func widthToHeight(_ constant: CGFloat = 0.0, options: [Option] = []) -> Pin {
        return Pin(.widthToHeight, constant: constant, options: options)
    }

    // MARK: - Initialisation

    fileprivate let type: LayoutType
    fileprivate var constant: CGFloat
    fileprivate var multiplier: CGFloat
    fileprivate var relation: NSLayoutConstraint.Relation
    fileprivate var priority: UILayoutPriority
    fileprivate var isActive: Bool

    private init(_ type: LayoutType, constant: CGFloat = 0.0, options: [Option] = []) {

        self.type = type
        self.constant = constant
        self.multiplier = 1.0
        self.relation = .equal
        self.priority = .almostRequired
        self.isActive = true

        // If you add an option twice, the last value will be used
        for option in options {
            switch option {
            case .multiplier(let value):
                multiplier = value
            case .priority(let value):
                priority = value
            case .relation(let value):
                relation = value
            case .isActive(let value):
                isActive = value
            }
        }
    }

    fileprivate enum LayoutType {

        // Base

        case left
        case right
        case top
        case bottom
        case leading
        case trailing
        case width(Bool)
        case height(Bool)
        case centerX
        case centerY
        case lastBaseline
        case firstBaseline
        case leftMargin
        case rightMargin
        case topMargin
        case bottomMargin
        case leadingMargin
        case trailingMargin
        case centerXWithinMargins
        case centerYWithinMargins
        case none

        // Extended

        case below
        case above
        case leftOf
        case rightOf

        case heightToWidth
        case widthToHeight

        case custom(NSLayoutConstraint.Attribute, NSLayoutConstraint.Attribute)

        case bottomToCenterY
        case topToCenterY
        case centerXToLeading
        case centerXToTrailing
        case centerYToTop
        case centerYToBottom

        var attribute: NSLayoutConstraint.Attribute {

            switch self {
            case .left:
                return .left
            case .right:
                return .right
            case .top:
                return .top
            case .bottom:
                return .bottom
            case .leading:
                return .leading
            case .trailing:
                return .trailing
            case .width:
                return .width
            case .height:
                return .height
            case .centerX:
                return .centerX
            case .centerY:
                return .centerY
            case .lastBaseline:
                return .lastBaseline
            case .firstBaseline:
                return .firstBaseline
            case .leftMargin:
                return .leftMargin
            case .rightMargin:
                return .rightMargin
            case .topMargin:
                return .topMargin
            case .bottomMargin:
                return .bottomMargin
            case .leadingMargin:
                return .leadingMargin
            case .trailingMargin:
                return .trailingMargin
            case .centerXWithinMargins:
                return .centerXWithinMargins
            case .centerYWithinMargins:
                return .centerYWithinMargins
            case .none:
                return .notAnAttribute

            case .below:
                return .top
            case .above:
                return .bottom
            case .leftOf:
                return .right
            case .rightOf:
                return .left
            case .heightToWidth:
                return .height
            case .widthToHeight:
                return .width
            case .bottomToCenterY:
                return .bottom
            case .topToCenterY:
                return .top
            case .centerXToLeading:
                return .centerX
            case .centerXToTrailing:
                return .centerX
            case .centerYToTop:
                return .centerY
            case .centerYToBottom:
                return .centerY

            case .custom(let value, _):
                return value
            }
        }

        var toAttribute: NSLayoutConstraint.Attribute {
            switch self {
            case .below:
                return .bottom
            case .above:
                return .top
            case .leftOf:
                return .left
            case .rightOf:
                return .right
            case .heightToWidth:
                return .width
            case .widthToHeight:
                return .height
            case .bottomToCenterY:
                return .centerY
            case .topToCenterY:
                return .centerY
            case .centerXToLeading:
                return .leading
            case .centerXToTrailing:
                return .trailing
            case .centerYToTop:
                return .top
            case .centerYToBottom:
                return .bottom
            case .width(let constant), .height(let constant):
                return constant ? .notAnAttribute : attribute
            case .custom(_, let value):
                return value
            default:
                return attribute
            }
        }

        var needsView: Bool {
            switch self {
            case .width, .height:
                return false
            default:
                return true
            }
        }

        var ignoreView: Bool {
            switch self {
            case .width(let constant), .height(let constant):
                return constant
            default:
                return false
            }
        }
    }
}

// MARK: - Misc

extension UILayoutPriority {
    public static let almostRequired = UILayoutPriority(Float(UILayoutPriority.required.rawValue) - 1.0)
    public static let flexible = UILayoutPriority(Float(UILayoutPriority.defaultHigh.rawValue) - 1.0)
    public static let veryFlexible = UILayoutPriority(Float(UILayoutPriority.defaultLow.rawValue) - 1.0)
}

extension UIView {
    private func activateIfNeeded(_ constraints: [LayoutConstraint]) {
        let constraintsToActivate = constraints.filter { $0.isActiveOnLaunch }
        LayoutConstraint.activate(constraintsToActivate)
    }
}

extension Array where Element == Pin {

    fileprivate func constraints(pinning item: UIView, toItem: UIView? = nil) -> [LayoutConstraint] {

        let constraints = self.compactMap { (pin) -> LayoutConstraint? in

            guard pin.type.attribute != .notAnAttribute else { return nil }
            if pin.type.needsView { guard toItem != nil else { return nil } }

            let toAttribute: NSLayoutConstraint.Attribute = toItem == nil ? .notAnAttribute : pin.type.toAttribute
            let constraint = LayoutConstraint(item: item,
                                              attribute: pin.type.attribute,
                                              relatedBy: pin.relation,
                                              toItem: pin.type.ignoreView ? nil : toItem,
                                              attribute: toAttribute,
                                              multiplier: pin.multiplier,
                                              constant: pin.constant)

            constraint.priority = pin.priority
            constraint.isActiveOnLaunch = pin.isActive

            return constraint
        }

        return constraints
    }
}

class LayoutConstraint: NSLayoutConstraint {
    var isActiveOnLaunch: Bool = true
}

private func PinAssert(_ message: String = "") {
    #if DEBUG
    print("PinAssert:", message)
    fatalError()
    #endif
}

/* Readme */

private class ExampleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        basics()
        twoSubviews()
        capturingConstraints()
        withOptions()
        customPins()
    }

    // MARK: - Examples

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        basics()
        twoSubviews()
        capturingConstraints()
        withOptions()
        customPins()
    }

    private func basics() {

        // Pinning to self

        let aSubview = UIView()
        addSubview(aSubview)
        aSubview.pin(to: self, [.leading, .top, .width, .height])

        // or

        aSubview.pin(to: self, [.centerX, .centerY, .width, .height])

        // or just

        aSubview.pin(to: self)

        // Pinning with padding

        aSubview.pin(to: self, [.leading(10.0), .top(10.0), .width(-20.0), .height(-20.0)])
    }

    func twoSubviews() {

        let firstView = UIView()
        addSubview(firstView)

        let secondView = UIView()
        addSubview(secondView)

        // Pinning one view to various different views and constant width / heights

        firstView.pin(to: self, [.leading(10.0), .centerY])
        firstView.pin([.width(100.0), .height(100.0)])

        secondView.pin(to: self, [.centerY])
        secondView.pin(to: firstView, [.rightOf(10.0), .width, .height])

        // Above Pins can also be expressed with different syntax

        firstView.pin(to: self, [.leading(10.0), .centerY, .width(asConstant: 100.0), .height(asConstant: 100.0)])

        secondView.pin(to: [self:      [.centerY],
                            firstView: [.rightOf(10.0), .width, .height]])
    }

    private var yConstraint: NSLayoutConstraint?
    private var someConstraints: [NSLayoutConstraint] = []

    private var wConstraint: NSLayoutConstraint?
    private var hConstraint: NSLayoutConstraint?

    func capturingConstraints() {

        let someView = UIView()
        addSubview(someView)

        yConstraint = someView.pin(to: self, [.leading, .centerY, .width, .height])[1]

        // or grab the entire array of constraints

        someConstraints = someView.pin(to: self, [.leading, .centerY, .width, .height])

        // or grab the entire array of constraints to capture two

        let constraints = someView.pin(to: self, [.leading, .centerY, .width, .height])

        wConstraint = constraints[2]
        hConstraint = constraints[3]
    }

    func withOptions() {

        let optionsSubview = UIView()
        addSubview(optionsSubview)

        // All options with their default values inside

        optionsSubview.pin(to: self, [.width(options: [.multiplier(1.0),
                                                       .priority(.almostRequired),
                                                       .isActive(true),
                                                       .relation(.equal)])])

        // Simple multiplier

        optionsSubview.pin(to: self, [.leading,
                                      .top,
                                      .width(options: [.multiplier(0.5)]),
                                      .height])

        // Multiple width pins with relation and priority

        optionsSubview.pin(to: self, [.leading(10.0),
                                      .top,
                                      .width(-20.0, options: [.relation(.lessThanOrEqual), .priority(.defaultLow)]),
                                      .width(asConstant: 100.0, options: [.relation(.greaterThanOrEqual), .priority(.defaultHigh)]),
                                      .height])

        // Multiple width pins with inactivity

        let constraints = optionsSubview.pin(to: self, [.leading(10.0),
                                                        .top,
                                                        .width(options: [.isActive(false)]),
                                                        .width(asConstant: 100.0, options: [.isActive(true)]),
                                                        .height])

        let fullWidthConstraint = constraints[2]
        let constantWidthConstraint = constraints[3]

        NSLayoutConstraint.activate([fullWidthConstraint])
        NSLayoutConstraint.deactivate([constantWidthConstraint])
    }

    func customPins() {

        let firstView = UIView()
        addSubview(firstView)
        firstView.pin(to: self, [.centerX, .centerY, .width(asConstant: 100.0), .heightToWidth])

        let secondView = UIView()
        addSubview(secondView)
        secondView.pin(to: firstView, [.leading(10.0),
                                       .custom(.centerY, to: .bottom),
                                       .width(-20.0),
                                       .height(-20.0)])
    }
}
