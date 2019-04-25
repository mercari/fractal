//
//  HelpOptionView.swift
//  DesignSystem
//
//  Created by anthony on 11/03/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import UIKit

public class HelpOptionView: UIView, Highlightable {

    public static let typography: BrandingManager.Typography = .medium

    public init() {
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(label)
        addSubview(imageView)
        label.pin(to: [self: [.leading(.keyline, options: [.relation(.lessThanOrEqual)]), .top(.small), .bottom(-.small)],
                       imageView: [.leftOf(-.small)]])
        imageView.pin(to: self, [.trailing(-.keyline), .centerY])
    }

    public func set(text: String) {
        label.text = text
    }

    public func set(for highlighted: Bool, selected: Bool) {
        let color = highlighted ? UIColor.brand().darker() : UIColor.brand()
        label.textColor = color
        imageView.tintColor = color
    }

    // MARK: - Properties

    private var label: Label = {
        let label = Label()
        label.apply(typography: HelpOptionView.typography, color: .brand())
        label.textAlignment = .right
        return label
    }()

    private var imageView: ImageView = {
        let imageView = ImageView(design: .smallArrow)
        imageView.tintColor = .brand()
        return imageView
    }()
}
