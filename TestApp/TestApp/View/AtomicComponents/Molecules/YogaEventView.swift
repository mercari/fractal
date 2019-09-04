//
//  YogaEventView.swift
//  TestApp
//
//  Created by anthony on 02/09/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

class YogaEventView: UIView {
    
    static var textHeight: CGFloat {
        return "X\nX".height(typography: .medium, width: CGFloat.greatestFiniteMagnitude)
    }
    
    init() {
        super.init(frame: .zero)
        addSubview(imageView)
        addSubview(label)

        imageView.pin(to: self, [.leading, .trailing, .top(.small), .bottom(-(YogaEventView.textHeight + .small*2))])
        label.pin(to: self, [.leading, .trailing])
        label.pin(to: imageView, [.below(.small)])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(title: String, image: UIImage?) {
        label.text = title
        imageView.image = image
    }

    // MARK: - Properties

    private var imageView: ImageView = {
        let imageView = ImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4.0
        return imageView
    }()

    private lazy var label: Label = {
        let label = Label()
        label.apply(typography: .medium, color: .text)
        label.numberOfLines = 2
        return label
    }()
}
