//
//  SegmentedControl.swift
//  DesignSystem
//
//  Created by acantallops on 2019/04/25.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import UIKit

public class SegmentedControl: UISegmentedControl {
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    override public init(items: [Any]?) {
        super.init(items: items)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        tintColor = .brand
        backgroundColor = .clear
    }

}
