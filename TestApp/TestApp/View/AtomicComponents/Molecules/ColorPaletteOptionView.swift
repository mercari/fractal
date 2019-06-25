//
//  ColorPaletteOptionView.swift
//  DesignSystemApp
//
//  Created by anthony on 15/01/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import DesignSystem

public class ColorPaletteOptionView: UIView {

    public init() {
        super.init(frame: .zero)
        addSubview(colorView)
        addSubview(label)
        colorView.pin(to: self, [.top, .centerX, .widthToHeight(-.keyline*2), .height(-.keyline*2)])
        label.pin(to: colorView, [.leading, .below(.xsmall), .width])
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(name: String, color: UIColor) {
        label.text = name
        colorView.backgroundColor = color
        colorView.layer.borderColor = color.darker(0.05).cgColor
        colorView.layer.borderWidth = color.equals(.white) ? 1.0: 0.0
    }

    // MARK: - Properties

    private lazy var colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var label: Label = {
        let label = Label()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.apply(typography: .xsmall)

        return label
    }()
}
