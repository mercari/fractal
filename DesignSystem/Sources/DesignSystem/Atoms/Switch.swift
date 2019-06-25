//
//  Switch.swift
//  DesignSample
//
//  Created by Anthony Smith on 11/09/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit

public final class Switch: UISwitch {

    public var dark: Bool = false { didSet { updateForDark() }}

    public init() {
        super.init(frame: .zero)
        layer.cornerRadius = bounds.size.height/2

        // for dark mode brand
        // thumbTintColor = .background(.cell)
        // backgroundColor = .atom(.switchTint)
        // tintColor = .atom(.switchTint)
    }

    @available (*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateForDark() {
        thumbTintColor = dark ? .text() : nil
    }
}
