//
//  SliderViewModel.swift
//  SectionSystem
//
//  Created by anthony on 28/01/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

extension SectionBuilder {
    public func slider(steps: Float, snapStyle: Slider.SnapStyle = .none, valueClosure: @escaping () -> (Float), didChangeClosure: @escaping (Float) -> Void) -> SliderSection {
        return SliderSection(steps: steps, snapStyle: snapStyle, valueClosure: valueClosure, didChangeClosure: didChangeClosure)
    }
}

public class SliderSection {
    fileprivate let steps: Float
    fileprivate let snapStyle: Slider.SnapStyle
    fileprivate let valueClosure: () -> (Float)
    fileprivate let didChangeClosure: (Float) -> Void

    init(steps: Float, snapStyle: Slider.SnapStyle, valueClosure: @escaping () -> (Float), didChangeClosure: @escaping (Float) -> Void) {
        self.steps = steps
        self.snapStyle = snapStyle
        self.valueClosure = valueClosure
        self.didChangeClosure = didChangeClosure
    }

    var snapIncrement: Float {
        switch snapStyle {
        case .none:
            return 0.0
        default:
            return 1.0 / Float(steps)
        }
    }
}

extension SliderSection: ViewSection {

    public func createView() -> UIView {
        return SliderView(steps: steps, snapStyle: snapStyle, didChangeClosure: didChangeClosure)
    }

    public func size(in view: UIView, at index: Int) -> SectionCellSize {
        return SectionCellSize(width: view.bounds.size.width, height: nil)
    }

    public var configure: (UIView, Int) -> Void {
        return { (view, index) in
            guard let sliderView = view as? SliderView else { return }
            sliderView.set(steps: self.steps, snapStyle: self.snapStyle, didChangeClosure: self.didChangeClosure)
            sliderView.set(value: self.valueClosure() / self.steps)
        }
    }
}
