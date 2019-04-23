//
//  InformationView.swift
//  DesignSystem
//
//  Created by anthony on 21/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//
import Foundation
import UIKit

public class InformationView: UIView {

    public init() {
        super.init(frame: .zero)
        backgroundColor = .background(.cell)
        addSubview(titleLabel)
        addSubview(detailLabel)
        titleLabel.pin(to: [self: [.leading(.keyline), .top(.small), .bottom(-.small)],
                            detailLabel: [.leftOf(-.default, options: [.relation(.lessThanOrEqual)])]])
        detailLabel.pin(to: self, [.trailing(-.keyline), .centerY, .width(options: [.multiplier(0.3)])])
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(text: String, detail: String) {
        titleLabel.text = text
        detailLabel.text = detail
    }

    // MARK: - Properties

    private var titleLabel: Label = {
        let label = Label()
        label.apply(typography: .medium)
        return label
    }()

    private lazy var detailLabel: Label = {
        let label = Label()
        label.apply(typography: .medium, color: .text(.information))
        label.textAlignment = .right
        return label
    }()
}
