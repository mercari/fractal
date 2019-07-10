//
//  NavigationOptionView.swift
//  DesignSystem
//
//  Created by anthony on 19/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//
import Foundation
import DesignSystem

extension NavigationOptionView: Highlightable {
    public func set(for highlighted: Bool, selected: Bool) {
        backgroundColor = (highlighted || selected) ? .background(.cellSelected) : .background(.cell)
    }
}

public class NavigationOptionView: UIView {

    /// design style for NavigationOptionView
    ///
    /// - `default`: default desing. title label add to view.
    /// - detail: detail label add to the right of title label. multiplier use to width for detail label
    /// - information: information label add to right side of view. multiplier use to width for information label
    public enum Style {
        case `default`
        case detail
        case information(constant: CGFloat)
    }

    public static let typography: BrandingManager.Typography = .medium
    public static let detailDisclosureWidth: CGFloat = ImageView(design: .detailDisclosure).frame.size.width

    private let style: Style

    public init(style: NavigationOptionView.Style) {
        self.style = style
        super.init(frame: .zero)
        setupForDesign()
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupForDesign() {

        backgroundColor = .background(.cell)
        addSubview(titleLabel)
        addSubview(disclosureImageView)

        pin([.height(BrandingManager.brand.defaultCellHeight, options: [.relation(.greaterThanOrEqual)])])

        disclosureImageView.pin(to: self, [.trailing(-.keyline), .centerY])
        titleLabel.pin(to: self, [.leading(.keyline), .top(.small)])
        titleLabel.setContentCompressionResistancePriority(.flexible, for: .horizontal)

        switch style {
        case .default:
            titleLabel.pin(to: [disclosureImageView: [.leftOf(-.small, options: [.relation(.lessThanOrEqual)])],
                                self: [.bottom(-.small)]])
        case .detail:
            titleLabel.numberOfLines = 3
            detailLabel.numberOfLines = 3
            addSubview(detailLabel)
            detailLabel.pin(to: [self: [.leading(.keyline), .bottom(-.small)],
                                 titleLabel: [.below(.small)],
                                 disclosureImageView: [.leftOf(-.small, options: [.relation(.lessThanOrEqual)])]])
            titleLabel.pin(to: disclosureImageView, [.leftOf(-.small, options: [.relation(.lessThanOrEqual)])])
            detailLabel.setContentCompressionResistancePriority(.flexible, for: .horizontal)

        case .information(let constant):
            addSubview(informationLabel)
            informationLabel.pin(to: [self: [.top(.small), .bottom(-.small), .width(asConstant: constant)],
                                      disclosureImageView: [.leftOf(-.small)]])
            titleLabel.pin(to: [informationLabel: [.leftOf(-.small, options: [.relation(.lessThanOrEqual)])],
                                self: [.bottom(-.small)]])
        }
    }

    public func set(title: String, detail: String?) {

        titleLabel.text = title

        switch style {
        case .default:
            break
        case .detail:
            detailLabel.text = detail ?? ""
        case .information:
            informationLabel.text = detail ?? ""
        }
    }

    // MARK: - Properties

    private var titleLabel: Label = {
        let label = Label()
        label.apply(typography: NavigationOptionView.typography)
        return label
    }()

    private var disclosureImageView: ImageView = {
        let imageView = ImageView(design: .detailDisclosure)
        imageView.contentMode = .center
        return imageView
    }()

    private lazy var detailLabel: Label = {
        let label = Label()
        label.apply(typography: NavigationOptionView.typography, color: .text(.information))
        return label
    }()

    private lazy var informationLabel: Label = {
        let label = Label()
        label.textAlignment = .right
        label.apply(typography: .medium(.strong))
        return label
    }()
}
