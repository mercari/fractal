//
//  UIViewController+Contain.swift
//  Mercari
//
//  Created by Anthony Smith on 25/04/2017.
//  Copyright © 2017 Mercari, Inc. All rights reserved.
//

import Foundation
import UIKit

public typealias ConstraintBlock = (UIView) -> ([NSLayoutConstraint])

public extension UIViewController {

    @discardableResult public func contain(_ viewController: UIViewController, constraintBlock: ConstraintBlock? = nil) -> [NSLayoutConstraint] {

        let containerView = UIView()

        addChild(viewController)
        containerView.addSubview(viewController.view)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.clipsToBounds = true

        let appliedConstraints: [NSLayoutConstraint]

        if let block = constraintBlock {
            appliedConstraints = block(containerView)
        }
        else {

            // Example of constraint block.
            // Note: `self.view.addSubview(cView)` also belongs in this block
            // as it's not assumed you want to add it to self.view
            let block: ConstraintBlock = { [weak self] (cView) -> ([NSLayoutConstraint]) in

                guard let `self` = self else { return [] }

                self.view.addSubview(cView)

                let x = cView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
                let y = cView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
                let w = cView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
                let h = cView.heightAnchor.constraint(equalTo: self.view.heightAnchor)

                return [x, y, w, h]
            }

            appliedConstraints = block(containerView)
        }

        NSLayoutConstraint.activate(appliedConstraints)
        viewController.view.frame = containerView.bounds

        if !viewController.view.translatesAutoresizingMaskIntoConstraints {
            viewController.view.pin(to: containerView, [.top, .bottom, .left, .right])
        } else if !viewController.view.autoresizingMask.contains(.flexibleWidth) {
            viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }

        viewController.didMove(toParent: self)

        return appliedConstraints
    }
}
