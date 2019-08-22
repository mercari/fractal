//
//  DividerView.swift
//  DesignSystem
//
//  Created by anthony on 19/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//
import Foundation
import UIKit

public class DividerView: UIView {

    public enum Style { // TODO: Many of these properties need to flex on brand. Create protocol for Brands
        case full, indented(CGFloat), indentedBoth(CGFloat)

        public var color: UIColor {
            return .atom(.divider)
        }

        public var leadPadding: CGFloat {
            switch self {
            case .full:
                return 0.0
            case .indentedBoth(let indent), .indented(let indent):
                return indent
            }
        }

        public var trailingPadding: CGFloat {
            switch self {
            case .full, .indented:
                return 0.0
            case .indentedBoth:
                return .keyline
            }
        }

        public var height: CGFloat {
            return .divider
        }

        public var name: String {
            switch self {
            case .full:
                return "full"
            case .indentedBoth(let indent):
                return "indentedBoth_\(indent)"
            case .indented(let indent):
                return "indented_\(indent)"
            }
        }
    }

    private var lConstraint: NSLayoutConstraint?
    private var tConstraint: NSLayoutConstraint?
    private let style: Style

    public init(style: Style) {
        self.style = style
        super.init(frame: .zero)

        addSubview(divider)
        backgroundColor = .background(.cell)
        let constraints = divider.pin(to: self, [.leading, .bottom, .trailing])
        lConstraint = constraints[0]
        tConstraint = constraints[2]
        setForStyle()
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setForStyle() {
        divider.pin([.height(asConstant: style.height)])
        divider.backgroundColor = style.color
        lConstraint?.constant = style.leadPadding
        tConstraint?.constant = -style.trailingPadding

        // Potentially all cells need this... in a collectionview, small clear gaps will appear if setting a value of less than 1.0
        pin([.height(1.0, options: [.relation(.greaterThanOrEqual)])])
    }

    // MARK: - Properties
    
    private var divider: UIView = {
        let view = UIView()
        return view
    }()
}
