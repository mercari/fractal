//
//  TextDividerView.swift
//  DesignSystem
//
//  Created by anthony on 18/02/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation

public class TextDividerView: UIView {

    public enum Style { // TODO: Many of these properties need to flex on brand. Create protocol for Brands
        case noLine, full, indented

        public var padding: CGFloat {
            switch self {
            case .full, .noLine:
                return 0.0
            case .indented:
                return .keyline
            }
        }

        public var lineHidden: Bool {
            return self == .noLine
        }
    }

    private var lConstraint: NSLayoutConstraint?
    private var tConstraint: NSLayoutConstraint?
    private let color: UIColor = .divider(.accent)

    public static let typography: BrandingManager.Typography = .medium

    public init(style: Style) {
        super.init(frame: .zero)

        addSubview(leadingDivider)
        addSubview(trailingDivider)
        addSubview(label)

        //TODO: allow for design system constant changes...

        lConstraint = leadingDivider.pin(to: self, [.leading, .centerY, .height(asConstant: .divider)])[0]
        tConstraint = trailingDivider.pin(to: self, [.trailing, .centerY, .height(asConstant: .divider)])[0]

        leadingDivider.pin(to: label, [.leftOf(-.keyline)])
        trailingDivider.pin(to: label, [.rightOf(.keyline)])

        label.pin(to: self, [.centerX,
                             .centerY,
                             .width(options: [.multiplier(0.5), .relation(.lessThanOrEqual)])])
        set(for: style)
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(title: String, style: Style) {
        label.text = title
        set(for: style)
    }

    private func set(for style: Style) {
        leadingDivider.isHidden = style.lineHidden
        trailingDivider.isHidden = style.lineHidden
        lConstraint?.constant = style.padding
        tConstraint?.constant = -style.padding
    }

    // MARK: - Properties

    private lazy var leadingDivider: UIView = {
        let view = UIView()
        view.backgroundColor = color
        return view
    }()

    private lazy var trailingDivider: UIView = {
        let view = UIView()
        view.backgroundColor = color
        return view
    }()

    private lazy var label: Label = {
        let label = Label()
        label.apply(typography: TextDividerView.typography, color: color)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
}
