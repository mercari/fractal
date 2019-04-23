//
//  GradientView.swift
//  Mercari-Common
//
//  Created by Anthony Smith on 20/12/2017.
//  Copyright © 2017 mercari. All rights reserved.
//

import Foundation
import UIKit

final public class GradientView: UIView {

    var defaultLocations = [NSNumber]()

    override public class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    init() {
        super.init(frame: .zero)
        setup()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.frame = bounds
    }

    // MARK: - Build

    public func addGradient(with colors: [UIColor], locations: [NSNumber] = [], horizontal: Bool = false) {

        if locations.count == 0, colors.count > 1 {
            set(locations: createLocations(colors.count))
        }
        else {
            set(locations: locations)
        }

        set(colors: colors)
        set(horizontal: horizontal)
    }

    public func createLocations(_ count: Int) -> [NSNumber] {

        let variant: Float = 1.0 / Float(count-1)
        var locations = [NSNumber]()

        for i in 0..<count {
            locations.append(NSNumber(value: variant * Float(i)))
        }

        return locations
    }

    public func set(colors: [UIColor]) {

        guard let gradientLayer = self.layer as? CAGradientLayer else { return }

        guard colors.count > 0 else { set(colors: [.clear, .clear]); return }
        guard colors.count > 1 else { set(colors: [colors[0].withAlphaComponent(0.0), colors[0]]); return }

        var cgColors = [CGColor]()

        for color in colors {
            cgColors.append(color.cgColor)
        }

        gradientLayer.colors = cgColors
    }

    public func set(locations: [NSNumber]) {

        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.locations = locations
        defaultLocations = locations
    }

    public func set(horizontal: Bool) {

        guard let gradientLayer = self.layer as? CAGradientLayer else { return }

        if horizontal {

            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        else {

            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        }
    }
}
