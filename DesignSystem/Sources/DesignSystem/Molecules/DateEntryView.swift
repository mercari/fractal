//
//  DateEntryView.swift
//  Home
//
//  Created by plimc on 2019/03/11.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import UIKit

public class DateEntryView: UIView {

    let style: Style

    public enum Style: String {
        case `default`, disclosureText

        public var showDisclosureLabel: Bool {
            switch self {
            case .default:
                return false
            case .disclosureText:
                return true
            }
        }
    }

    public init(style: Style) {
        self.style = style
        super.init(frame: .zero)
        setupForDesign()
    }

    public init() {
        self.style = .default
        super.init(frame: .zero)
        setupForDesign()
    }

    public override init(frame: CGRect) {
        self.style = .default
        super.init(frame: frame)
        setupForDesign()
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(displayTime: Date?, text: String?, disclosureText: String?) {
        dateView.text = BrandingManager.dateManager.string(from: displayTime, style: .detailed)
        detailLabel.text = text

        if style == .disclosureText {
            disclosureLabel.text = disclosureText
        }
    }

    // MARK: - Private

    private func setupForDesign() {

        addSubview(dateView)
        addSubview(detailLabel)
        addSubview(disclosureImageView)

        dateView.pin(to: self, [.leading(.keyline), .top(.small)])
        disclosureImageView.pin(to: self, [.trailing(-.keyline), .centerY])
        detailLabel.pin(to: [self: [.leading(.keyline), .bottom(-.xsmall)],
                             dateView: [.below(.xsmall)]])

        disclosureImageView.setContentCompressionResistancePriority(.required, for: .horizontal)

        if style.showDisclosureLabel {

            addSubview(disclosureLabel)
            disclosureLabel.pin(to: disclosureImageView, [.leftOf(-.small), .centerY])
            detailLabel.pin(to: disclosureLabel, [.leftOf(-.small, options: [.relation(.lessThanOrEqual)])])

            detailLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1), for: .horizontal)
            disclosureLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        } else {
            detailLabel.pin(to: disclosureImageView, [.leftOf(-.small, options: [.relation(.lessThanOrEqual)])])
        }

        backgroundColor = .background(.cell)
    }

    private var dateView: DateDisplayView = {
        let view = DateDisplayView()
        return view
    }()

    private lazy var disclosureImageView: ImageView = {
        let imageView = ImageView(design: .detailDisclosure, renderingMode: .alwaysTemplate)
        imageView.tintColor = self.detailLabel.textColor
        return imageView
    }()

    private lazy var detailLabel: Label = {
        let label = Label()
        label.numberOfLines = 0
        label.apply(typography: BrandingManager.isBoxBrand ? .mediumStrong : .medium, color: .text(.primary))
        return label
    }()

    private lazy var disclosureLabel: Label = {
        let label = Label()
        label.numberOfLines = 0
        label.apply(typography: BrandingManager.isBoxBrand ? .mediumStrong : .medium)
        return label
    }()
}

extension DateEntryView: Highlightable {
    public func set(for highlighted: Bool, selected: Bool) {
        backgroundColor = (highlighted || selected) ? .background(.cellSelected) : .background(.cell)
    }
}
