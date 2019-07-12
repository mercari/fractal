//
//  IconSelectView.swift
//  TestApp
//
//  Created by anthony on 11/07/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

class IconSelectView: UIView {

    init() {
        super.init(frame: .zero)
        addSubview(iconImageView)
        addSubview(selectedImageView)
        iconImageView.pin(to: self)
        selectedImageView.pin(to: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties

    var iconImageView: ImageView = {
        let imageView = ImageView()
        imageView.layer.cornerRadius = 8.0
        return imageView
    }()

    var selectedImageView: ImageView = {
        let imageView = ImageView(.check, renderingMode: .alwaysTemplate)
        imageView.tintColor = .atom(.check)
        imageView.contentMode = UIView.ContentMode.bottomRight
        return imageView
    }()
}
