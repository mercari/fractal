//
//  SegmentedControlView.swift
//  DesignSystem
//
//  Created by acantallops on 2019/04/25.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import DesignSystem

public class SegmentedControlView: UIView {

    private var didChange: ((Int?) -> Void)?

    public init(items: [Any]) {
        segmentedControl = SegmentedControl(items: items)
        super.init(frame: .zero)
        segmentedControl.addTarget(self, action: #selector(changeSelected), for: .valueChanged)
        setupForDesign()
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupForDesign() {
        backgroundColor = .background()
        segmentedControl.tintColor = .brand()
        addSubview(segmentedControl)
        segmentedControl.pin(to: self, [.leading(.keyline), .trailing(-.keyline), .centerY])
        pin([.height(asConstant: BrandingManager.brand.defaultCellHeight)])
    }

    public func set(value: Int?, didChangeClosure: @escaping (Int?) -> Void) {
        set(value: value)
        didChange = didChangeClosure
    }

    public func set(value: Int?) {
        segmentedControl.selectedSegmentIndex = value ?? UISegmentedControl.noSegment
    }

    @objc private func changeSelected() {
        didChange?(segmentedControl.selectedSegmentIndex)
    }

    // MARK: - Properties

    private let segmentedControl: SegmentedControl
}
