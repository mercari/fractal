//
//  StarRatingView.swift
//  DesignSystem
//
//  Created by anthony on 11/04/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation

public class StarRatingView: UIStackView {

    private static let starCount: Int = 5
    private static let iconSize: CGSize = CGSize(width: 12.0, height: 12.0)
    public static var height: CGFloat = {
        let date = BrandingManager.dateManager.string(from: Date())
        return max(StarRatingView.iconSize.height, date.height(typography: .xsmall, width: CGFloat.greatestFiniteMagnitude))
    }()

    private var stars = [ImageView]()

    init() {
        super.init(frame: .zero)
        axis = .horizontal
        spacing = .xxsmall

        for _ in 0..<StarRatingView.starCount {
            let imageView = ImageView(design: .starOff)
            addArrangedSubview(imageView)
            imageView.pin([.width(asConstant: StarRatingView.iconSize.width), .height(asConstant: StarRatingView.iconSize.height)])
        }

        addArrangedSubview(label)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(rating: CGFloat, count: Int) {

        for i in 0..<stars.count {
            let star = stars[i]
            let floatValue = CGFloat(i) + 1.0

            if rating >= floatValue {
                star.image = UIImage.with(design: .starOn)
            } else if rating > floatValue - 1.0 {
                star.image = UIImage.with(design: .starHalf)
            } else {
                star.image = UIImage.with(design: .starOff)
            }
        }

        label.text = "\(count)"
    }

    // MARK: - Properties

    private var label: Label = {
        let label = Label()
        label.apply(typography: .xsmallNoAccessibility, color: .text(.information))
        label.text = "0"
        return label
    }()
}
