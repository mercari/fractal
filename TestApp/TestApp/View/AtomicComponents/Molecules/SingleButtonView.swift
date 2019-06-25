//
//  SingleButtonView.swift
//  DesignSystem
//
//  Created by Anthony Smith on 09/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import DesignSystem

public class SingleButtonView: UIView {

    private let style: Button.Style
    private var closure: (() -> Void)?

    public init(style: Button.Style) {
        self.style = style
        super.init(frame: .zero)
        guard let buttonBrand = BrandingManager.brand as? ButtonBrand else { Assert("BrandingManager.brand does not conform to ButtonBrand"); return }
        addSubview(button)
        let size = Button.Size(width: .full, height: .large)
        button.pin(to: self, [.top(.xxsmall), .bottom(-.xxsmall), .centerX, buttonBrand.widthPin(for: size), buttonBrand.heightPin(for: size)])
        // Potentially change this widthPin / heightPin setup
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(buttonTitle: String, selected: Bool, closure:@escaping () -> Void) {
        button.setTitle(buttonTitle, for: .normal)
        button.isSelected = selected
        self.closure = closure
    }

    @objc private func tapped() {
        closure?()
    }

    // MARK: - Properties

    public lazy var button: Button = {
        let button = Button(style: self.style)
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        return button
    }()
}
