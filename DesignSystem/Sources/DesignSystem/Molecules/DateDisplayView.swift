//
//  DateDisplayView.swift
//  DesignSystem
//
//  Created by anthony on 28/03/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import UIKit

public class DateDisplayView: UIStackView {

    public var text: String? { didSet { dateLabel.text = text }}

    private static let iconSize: CGSize = CGSize(width: 12.0, height: 12.0)

    public static var height: CGFloat = {
        let date = BrandingManager.dateManager.string(from: Date())
        return max(DateDisplayView.iconSize.height, date.height(typography: .xsmall, width: CGFloat.greatestFiniteMagnitude))
    }()

    init() {
        super.init(frame: .zero)

        axis = .horizontal
        spacing = .xxsmall

        addArrangedSubview(clockIcon)
        addArrangedSubview(dateLabel)

        clockIcon.pin([.width(asConstant: DateDisplayView.iconSize.width),
                       .height(asConstant: DateDisplayView.iconSize.height)])
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties

    private var dateLabel: Label = {
        let label = Label()
        label.apply(typography: .xsmallNoAccessibility, color: .text(.information))
        return label
    }()

    private lazy var clockIcon: ImageView = {
        let imageView = ImageView(design: .clock4pm, renderingMode: .alwaysTemplate)
        imageView.tintColor = .text(.information)
        return imageView
    }()
}
