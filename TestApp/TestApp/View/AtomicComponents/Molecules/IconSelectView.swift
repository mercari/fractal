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
        iconImageView.pin(to: self, [.top(.small), .leading(.small), .trailing(-.small), .bottom(-.small - 20.0)])
        selectedImageView.pin(to: self, [.top, .leading, .trailing(-5.0), .bottom(-10.0)])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(_ key: UIImage.Key, isSelected: Bool) {
        iconImageView.image = UIImage.with(key)
        selectedImageView.isHidden = !isSelected
    }

    // MARK: - Properties

    var iconImageView: ImageView = {
        let imageView = ImageView()
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.atom(.divider).cgColor
        return imageView
    }()

    var selectedImageView: ImageView = {
        let imageView = ImageView(.check, renderingMode: .alwaysTemplate)
        imageView.tintColor = .atom(.check)
        imageView.contentMode = UIView.ContentMode.bottomRight
        return imageView
    }()
}
