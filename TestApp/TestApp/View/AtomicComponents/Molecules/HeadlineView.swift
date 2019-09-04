//
//  HeadlineView.swift
//  DesignSystem
//
//  Created by Anthony Smith on 12/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import DesignSystem

public class HeadlineView: UIView {

    public enum Style: String {
        case `default`, detail

        public var typography: BrandingManager.Typography {
            switch self {
            case .default:
                return .large
            default:
                return .medium
            }
        }

        public var color: UIColor {
            switch self {
            case .default:
                return .text(.information)
            default:
                return .text
            }
        }

        public var topPadding: CGFloat {
            switch self {
            case .default:
                return .large
            default:
                return .medium
            }
        }
    }

    private let style: Style

    public init(style: Style = .default) {
        self.style = style
        super.init(frame: .zero)
        addSubview(label)
        label.pin(to: self, [.leading(.keyline),
                             .bottom(-.small),
                             .top(style.topPadding),
                             .width(-.keyline*2, options: [.relation(.lessThanOrEqual)])])
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(text: String) {
        label.text = text
    }

    // MARK: - Properties

    private lazy var label: Label = {
        let label = Label()
        label.apply(typography: self.style.typography, color: self.style.color)
        label.numberOfLines = 0
        return label
    }()
}
