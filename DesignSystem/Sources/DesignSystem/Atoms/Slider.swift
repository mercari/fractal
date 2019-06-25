//
//  Slider.swift
//  DesignSystem
//
//  Created by anthony on 25/01/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import UIKit

public class Slider: UISlider {

    public enum SnapStyle {
        case none, always, loose([Float])
    }

    private var didChangeClosure: ((Float) -> Void)?
    private var snapIncrement: Float
    private var snapStyle: SnapStyle
    private var previousTransmittedValue: Float = 0.0
    private var steps: Float

    public init(steps: Float, snapStyle: SnapStyle = .none, snapIncrement: Float = 0.0) {
        self.steps = steps
        self.snapStyle = snapStyle
        self.snapIncrement = 1.0 / steps
        super.init(frame: .zero)
        thumbTintColor = nil

        minimumTrackTintColor = .atom(.sliderPositiveTint)
        maximumTrackTintColor = .atom(.sliderNegativeTint)

        addTarget(self, action: #selector(changed), for: .valueChanged)
        addTarget(self, action: #selector(end), for: [.touchUpInside, .touchUpOutside])
    }

    @available (*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(steps: Float, snapStyle: SnapStyle = .none, didChangeClosure: @escaping ((Float) -> Void)) {
        self.steps = steps
        self.snapStyle = snapStyle
        self.snapIncrement = 1.0 / steps
        self.didChangeClosure = didChangeClosure
    }

    @objc public func changed() {

        let potentialValue: Float

        switch snapStyle {
        case .always:
            potentialValue = round(value * steps)
        default:
            potentialValue = value * steps
        }

        value = potentialValue / steps
        guard potentialValue != previousTransmittedValue else { return }
        previousTransmittedValue = potentialValue
        didChangeClosure?(potentialValue)
    }

    @objc private func end() {
        switch snapStyle {
        case .loose(let looseValues):

            var closestValue: Float?
            var smallestGap: Float = snapIncrement

            for looseValue in looseValues {
                let percentValue = looseValue / steps
                let proximity = min(abs(value - percentValue), abs(percentValue - value))
                if proximity < smallestGap {
                    smallestGap = proximity
                    closestValue = percentValue
                }
            }

            guard let newValue = closestValue else { return }
            value = newValue
        default:
            break
        }
    }
}
