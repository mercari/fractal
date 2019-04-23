//
//  ItemView.swift
//  DesignSystem
//
//  Created by anthony on 22/04/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import UIKit

class ItemView: UIView {

    private static let priceBGViewHeight: CGFloat = 20.0

    public init() {
        super.init(frame: .zero)
        setup()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        clipsToBounds = true
        addSubview(imageView)

        if BrandingManager.isBoxBrand {
            addSubview(priceBackgroundView)
            priceBackgroundView.pin(to: priceLabel, [.leading(-(ItemView.priceBGViewHeight + .xsmall)),
                                                     .centerY,
                                                     .width(ItemView.priceBGViewHeight + .xsmall*2),
                                                     .height(asConstant:ItemView.priceBGViewHeight)])
        } else {
            addSubview(gradientView)
            gradientView.pin(to: imageView)
        }

        addSubview(priceLabel)
        addSubview(soldView)

        priceLabel.pin(to: self, [.leading(.xsmall),
                                  .width(-.xsmall*2, options: [.relation(.lessThanOrEqual)]),
                                  .bottom(-.xsmall)])

        soldView.pin(to: self, [.custom(.centerY, to: .top),
                                .custom(.centerX, to: .leading),
                                .width(options: [.multiplier(0.6)]),
                                .height(options: [.multiplier(0.6)])])

        imageView.pin(to: self)
    }

    public func set(image: UIImage, price: String, isSold: Bool) {

    }

    // MARK: - Properties

    private lazy var priceBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .background(.layerMiddle)
        view.layer.cornerRadius = ItemView.priceBGViewHeight/2
        return view
    }()

    private lazy var gradientView: GradientView = {
        let gradientView = GradientView()
        gradientView.addGradient(with: [.clear, .background(.layerDark)], locations: [0.5,1.0])
        return gradientView
    }()

    private var soldView: SoldView = {
        let soldView = SoldView()
        soldView.transform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi) / 4.0)
        return soldView
    }()

    private var priceLabel: Label = {
        let label = Label()
        label.apply(typography: .mediumStrong, color: .text(.light))
        return label
    }()

    private var imageView: ImageView = {
        let imageView = ImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
}
