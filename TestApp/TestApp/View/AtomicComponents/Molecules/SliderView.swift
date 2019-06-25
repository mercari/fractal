//
//  SliderView.swift
//  DesignSystem
//
//  Created by anthony on 24/01/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import DesignSystem
import UIKit

public class SliderView: UIView {

    private var marks: [UIView]?
    private let slider: Slider

    public init(steps: Float, snapStyle: Slider.SnapStyle = .none, didChangeClosure: @escaping (Float) -> Void) {

        slider = Slider(steps: steps, snapStyle: snapStyle)
        slider.isUserInteractionEnabled = false
        super.init(frame: .zero)
        addSubview(slider)
        set(steps: steps, snapStyle: snapStyle, didChangeClosure: didChangeClosure)
        refresh()

        let dragGestureRecogniser = UIPanGestureRecognizer(target: self, action: #selector(didDrag))
        self.addGestureRecognizer(dragGestureRecogniser)

        _ = NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: BrandingManager.didChange), object: nil, queue: nil) { [weak self] (_) in
            self?.refresh()
        }
    }

    @objc private func didDrag(dragGestureRecogniser: UIPanGestureRecognizer) {
        let location = dragGestureRecogniser.location(in: self)

        if dragGestureRecogniser.state == .began {
            guard location.x > slider.frame.origin.x && location.x < (slider.frame.size.width - slider.frame.origin.x) else { return }
        }

        let percentage = location.x / (bounds.size.width - .keyline*2)
        slider.value = Float(percentage)
        slider.changed()
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(steps: Float, snapStyle: Slider.SnapStyle, didChangeClosure: @escaping (Float) -> Void) {
        slider.set(steps: steps, snapStyle: snapStyle, didChangeClosure: didChangeClosure)
    }

    private func refresh() {
        backgroundColor = .background(.cell)
        slider.removeConstraints(slider.constraints)
        slider.pin(to: self, [.leading(.keyline), .trailing(-.keyline), .centerY])
        pin([.height(BrandingManager.brand.defaultCellHeight, options: [.relation(.greaterThanOrEqual)])])
    }

    public func set(value: Float) {
        slider.value = value
    }
}
