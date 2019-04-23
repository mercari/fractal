//
//  SoldView.swift
//  DesignSystem
//
//  Created by anthony on 22/04/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import UIKit

class SoldView: UIView {

    init() {
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .background(.attention)
        addSubview(titleLabel)
        titleLabel.pin(to: self, [.bottom, .centerX, .width])
    }

    private var titleLabel: Label = {

        let label = Label()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.apply(typography: .mediumStrong)
        label.text = "Sold".uppercased() // TODO: Localized
        label.textAlignment = .center
        label.textColor = .text(.light)

        return label
    }()
}
