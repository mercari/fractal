//
//  SwitchOptionView.swift
//  DesignSystem
//
//  Created by anthony on 24/01/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import DesignSystem

public class SwitchOptionView: UIView {

    public enum Style: String {
        case `default`, detail
    }

    private let style: Style
    private var didChange: ((Bool) -> Void)?

    public init(style: SwitchOptionView.Style) {
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
        addSubview(toggleSwitch)
        backgroundColor = .background(.cell)

        pin([.height(BrandingManager.brand.defaultCellHeight, options: [.relation(.greaterThanOrEqual)])])

        titleLabel.setContentCompressionResistancePriority(.flexible, for: .horizontal)

        toggleSwitch.pin(to: self, [.trailing(-.keyline), .centerY])
        titleLabel.pin(to: [self:         [.leading(.keyline)],
                            toggleSwitch: [.leftOf(-.keyline, options: [.relation(.lessThanOrEqual)])]])

        switch style {
        case .default:
            titleLabel.pin(to: self, [.top(.small), .bottom(-.small)])
        case .detail:
            addSubview(detailLabel)
            titleLabel.pin(to: self, [.top(.small)])
            detailLabel.pin(to: [self: [.bottom(-.small)],
                                 titleLabel: [.leading, .below(.small)],
                                 toggleSwitch: [.leftOf(-.keyline, options: [.relation(.lessThanOrEqual)])]
            ])
            detailLabel.setContentCompressionResistancePriority(.flexible, for: .horizontal)
        }
    }

    public func set(title: String, detail: String?, didChangeClosure: @escaping (Bool) -> Void) {

        titleLabel.text = title
        didChange = didChangeClosure

        switch style {
        case .default:
            break
        case .detail:
            detailLabel.text = detail
        }
    }

    public func set(value: Bool, animated: Bool) {
        toggleSwitch.setOn(value, animated: animated)
    }

    @objc private func toggled() {
        didChange?(toggleSwitch.isOn)
    }

    // MARK: - Properties

    private var titleLabel: Label = {
        let label = Label()
        label.apply(typography: .medium)
        label.numberOfLines = 3
        return label
    }()

    private lazy var toggleSwitch: Switch = { [weak self] in
        let toggleSwitch = Switch()
        toggleSwitch.addTarget(self, action: #selector(toggled), for: .valueChanged)
        return toggleSwitch
    }()

    private lazy var detailLabel: Label = {
        let label = Label()
        label.apply(typography: .medium, color: .text(.information))
        label.numberOfLines = 3
        return label
    }()
}
