//
//  BounceScaleImageView.swift
//  DesignSystem
//
//  Created by anthony on 21/02/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import DesignSystem

public class BounceScaleImageView: UIView {

    private var multiplier: CGFloat = 0.0
    private var defaultHeight: CGFloat = 0.0
    private var threshold: CGFloat = 0.0

    private var hConstraint: NSLayoutConstraint?
    private var yConstraint: NSLayoutConstraint?

    public var image: UIImage? {
        didSet{
            imageView.image = image
            setBlurIntensity(0.0) // Unsure why this is here
        }
    }

    private var useBlurEffect: Bool = false

    private let blurIntensity: CGFloat = 0.35

    public init(imageHeight: CGFloat, scaleThreshold: CGFloat = 0.0, withBlur: Bool) {

        super.init(frame: .zero)

        useBlurEffect = withBlur
        threshold = scaleThreshold
        defaultHeight = imageHeight
        setupView()
    }

    public init(multiplier: CGFloat) {

        super.init(frame: .zero)
        self.multiplier = multiplier
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {

        clipsToBounds = true
        addSubview(imageView)

        imageView.pin(to: self, [.centerX, .top, .width, .height])

        if useBlurEffect {
            imageView.addSubview(blurView)
            imageView.addSubview(darkCoverView)
            blurView.pin(to: imageView)
            darkCoverView.pin(to: imageView)
        }

        setParallax(0.0)
    }

    public func applyConstraints() {

        guard let superview = superview else { Assert("No superview set"); return }
        let heightPin: Pin = multiplier != 0.0 ? .heightToWidth(options: [.multiplier(multiplier)]) : .height(asConstant: defaultHeight)
        let constraints = pin(to: superview, [.top, .centerX, .width, heightPin])

        yConstraint = constraints[0]
        hConstraint = constraints[3]
    }

    public func set(for offset: CGFloat) {
        setParallax(offset)
        if useBlurEffect {
            setBlurIntensity(offset)
        }
    }

    private func setParallax(_ offset: CGFloat) {

        if offset <= threshold {
            yConstraint?.constant = -threshold
            hConstraint?.constant = round(-offset) + imageHeight()
        } else {
            yConstraint?.constant = -threshold + round(-(offset - threshold)/2)
            hConstraint?.constant = defaultHeight - threshold
        }
    }

    private func setBlurIntensity(_ offset: CGFloat) {

        guard useBlurEffect else { return }

        // Less blur as you pull down.
        if #available(iOS 11.0, *) {
            if useBlurEffect && blurView.animator?.isRunning == false {
                blurView.animator?.stopAnimation(true)
                blurView.effect = nil
                let delta: CGFloat = max(blurIntensity - (abs(offset/4.0) / imageHeight() ), 0.0)
                let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
                blurView.animator = UIViewPropertyAnimator(duration: 0.1, curve: .linear) { self.blurView.effect = blurEffect }
                blurView.animator?.fractionComplete = delta
            }
        }
    }

    // MARK: - Accessors

    public func imageHeight() -> CGFloat {
        return multiplier == 0.0 ? defaultHeight : frame.size.height * multiplier
    }

    // MARK: - Properties

    private lazy var imageView: ImageView = {

        let imageView = ImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    private lazy var blurView: CustomIntensityVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let view = CustomIntensityVisualEffectView(effect: blurEffect, intensity: self.blurIntensity)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var darkCoverView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.alpha = 0.2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

class CustomIntensityVisualEffectView: UIVisualEffectView {

    var animator: UIViewPropertyAnimator?

    /// Create visual effect view with given effect and its intensity
    ///
    /// - Parameters:
    /// - effect: visual effect, eg UIBlurEffect(style: .dark)
    /// - intensity: custom intensity from 0.0 (no effect) to 1.0 (full effect) using linear scale

    init(effect: UIVisualEffect, intensity: CGFloat) {
        super.init(effect: nil)
        animator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [unowned self] in self.effect = effect }
        animator?.fractionComplete = intensity
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
