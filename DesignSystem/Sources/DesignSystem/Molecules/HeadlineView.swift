//
//  HeadlineView.swift
//  DesignSystem
//
//  Created by Anthony Smith on 12/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit

public class HeadlineView: UIView {

    public enum Style: String {
        case `default`, detail

        public var typography: BrandingManager.Typography {
            switch self {
            case .default:
                return .xxlargeStrong
            default:
                return .medium
            }
        }

        public var topPadding: CGFloat {
            switch self {
            case .default:
                return .xxlarge
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
                             .bottom(-.xsmall),
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
        label.apply(typography: self.style.typography)
        label.numberOfLines = 0
        return label
    }()
}
