//
//  AdvertView.swift
//  DesignSystem
//
//  Created by anthony on 22/04/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import UIKit

public class AdvertView: UIView {

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
        imageView.pin(to: self)
    }

    public func set(image: UIImage?) {
        imageView.image = image
    }

    // MARK: - Properties

    private var imageView: ImageView = {
        let imageView = ImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
}
