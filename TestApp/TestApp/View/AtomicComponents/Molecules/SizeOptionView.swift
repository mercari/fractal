//
//  SizeOptionView.swift
//  DesignSystemApp
//
//  Created by anthony on 17/01/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import DesignSystem

public class SizeOptionView: UIView {

    private var wConstraint: NSLayoutConstraint?
    private var hConstraint: NSLayoutConstraint?

    public init() {
        super.init(frame: .zero)
        addSubview(sizeView)
        addSubview(label)

        label.pin(to: [self: [.centerY, .trailing(-.keyline)],
                       sizeView: [.rightOf(.small)]])
        let constraints = sizeView.pin(to: self, [.centerY, .leading(.keyline), .width(asConstant: 1.0), .height(asConstant: 1.0)])
        wConstraint = constraints[2]
        hConstraint = constraints[3]
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(name: String, size: CGSize) {
        label.text = name
        hConstraint?.constant = size.height

        if size.width == 0.0 {
            wConstraint?.constant = .xsmall
            sizeView.backgroundColor = UIColor.brand().alpha(0.5)
            sizeView.layer.borderWidth = 1.0
        } else {
            wConstraint?.constant = size.width
            sizeView.backgroundColor = UIColor.black.alpha(0.3)
            sizeView.layer.borderWidth = 0.0
        }
    }

    // MARK: - Properties

    private lazy var sizeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.brand().cgColor

        return view
    }()

    private lazy var label: Label = {
        let label = Label()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.apply(typography: .small)
        label.numberOfLines = 0

        return label
    }()
}
