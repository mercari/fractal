//
//  TickBoxOptionView.swift
//  DesignSystem
//
//  Created by anthony on 10/04/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import DesignSystem

extension CheckboxOptionView: Highlightable {
    public func set(for highlighted: Bool, selected: Bool) {
        backgroundColor = (highlighted || selected) ? .background(.cellSelected) : .background(.cell)
    }
}

public class CheckboxOptionView: UIView {

    public enum Style: String {
        case `default`, detail
    }

    private let style: Style
    private var didChange: ((Bool) -> Void)?

    public init(style: Style) {
        self.style = style
        super.init(frame: .zero)
        setupForDesign()
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupForDesign() {

        addSubview(titleLabel)
        addSubview(imageView)
        backgroundColor = .background(.cell)

        titleLabel.setContentCompressionResistancePriority(.flexible, for: .horizontal)
        pin([.height(BrandingManager.brand.defaultCellHeight, options: [.relation(.greaterThanOrEqual)])])

        imageView.pin(to: self, [.trailing(-.keyline), .centerY])
        titleLabel.pin(to: [self: [.leading(.keyline)],
                            imageView: [.leftOf(-.xxsmall, options: [.relation(.lessThanOrEqual)])]])

        switch style {
        case .default:
            titleLabel.pin(to: self, [.top(.small), .bottom(-.small)])
        case .detail:
            addSubview(detailLabel)
            titleLabel.pin(to: self, [.top(.small)])
            detailLabel.pin(to: [self: [.bottom(-.small)],
                                 titleLabel: [.leading, .below(.small)],
                                 imageView: [.leftOf(-.keyline, options: [.relation(.lessThanOrEqual)])]
                ])
            detailLabel.setContentCompressionResistancePriority(.flexible, for: .horizontal)
        }
    }

    public func set(title: String, detail: String?) {
        titleLabel.text = title
        if style == .detail {
            detailLabel.text = detail
        }
    }

    public func set(isSelected: Bool) {
        imageView.isHidden = isSelected ? false : true
    }

    // MARK: - Properties

    private var titleLabel: Label = {
        let label = Label()
        label.apply(typography: .medium)
        label.numberOfLines = 1
        return label
    }()

    private lazy var detailLabel: Label = {
        let label = Label()
        label.apply(typography: .medium, color: .text(.information))
        label.numberOfLines = 1
        return label
    }()

    private var imageView: ImageView = {
        let imageView = ImageView(.check, in: BrandingManager.self, renderingMode: .alwaysTemplate)
        imageView.tintColor = .atom(.check)
        return imageView
    }()
}
