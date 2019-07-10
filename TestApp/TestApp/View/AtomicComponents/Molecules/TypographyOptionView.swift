//
//  TypographyOptionView.swift
//  DesignSystemApp
//
//  Created by anthony on 16/01/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import DesignSystem

class TypographyOptionView: UIView {

    public init() {
        super.init(frame: .zero)
        addSubview(label)
        addSubview(typeLabel)
        typeLabel.pin(to: [self: [.leading(.keyline), .width(-.keyline*2)],
                       label: [.above()]])
        label.pin(to: self, [.leading(.keyline), .bottom(-.small), .width(-.keyline*2)])
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(name: String, typography: BrandingManager.Typography) {
        typeLabel.text = typography.name
        label.text = name
        label.apply(typography: typography) // Normally I'd say this probably isn't ideal... but for this purpose as it's not customer facing it's ok
    }

    // MARK: - Properties

    private lazy var label: Label = {
        let label = Label()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0

        return label
    }()

    private lazy var typeLabel: Label = {
        let label = Label()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.apply(typography: .xxsmall)
        label.alpha = 0.5

        return label
    }()
}
