//
//  SliderViewModel.swift
//  SectionSystem
//
//  Created by anthony on 28/01/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation


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
    fileprivate weak var currentView: SliderView?

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

extension SliderSection: ViewSection, VisibleViewSection {

    public func createView() -> UIView {
        return SliderView(steps: steps, snapStyle: snapStyle, didChangeClosure: didChangeClosure)
    }

    public func size(in view: UIView, at index: Int) -> CGSize? {
        guard let brand = BrandingManager.brand as? NavigationBrand else {
            Assert("DesignSystem.brand does not conform to NavigationBrand")
            return CGSize(width: view.bounds.size.width, height: 44.0)
        }
        return CGSize(width: view.bounds.size.width, height: brand.defaultHeight)
    }

    public var configure: (UIView, Int) -> Void {
        return { (view, index) in
            guard let sliderView = view as? SliderView else { return }
            self.currentView = sliderView
            sliderView.set(steps: self.steps, snapStyle: self.snapStyle, didChangeClosure: self.didChangeClosure)
            sliderView.set(value: self.valueClosure() / self.steps)
        }
    }

    public var visibleView: UIView? {
        return currentView
    }

    public var visibleViews: [UIView]? {
        guard let view = currentView else { return [] }
        return [view]
    }

    public func viewBeingRecycled(_ view: UIView) {
        guard view == currentView else { return }
        currentView = nil
    }
}
