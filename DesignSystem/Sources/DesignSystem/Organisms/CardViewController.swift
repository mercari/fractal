//
//  CardViewController.swift
//  Mercari-Common
//
//  Created by Anthony Smith on 26/07/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit


public class CardViewController: UIViewController {

    public struct Option: OptionSet {
        
        public let rawValue: Int
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        public static let darkBackground = Option(rawValue: 1 << 0)
        public static let isFullscreen = Option(rawValue: 1 << 1)
        public static let showHandle = Option(rawValue: 1 << 2)
    }
    
    private class Snapshot {
        
        private weak var view: UIView?
        private var scrollViewSnapshots = [ScrollViewSnapshot]()
        
        private struct ScrollViewSnapshot {
            
            weak var scrollView: UIScrollView?
            let adjustmentBehavior: UIScrollView.ContentInsetAdjustmentBehavior
            let offsetY: CGFloat
            
            init(with scrollView: UIScrollView) {
                self.scrollView = scrollView
                adjustmentBehavior = scrollView.contentInsetAdjustmentBehavior
                offsetY = scrollView.contentOffset.y
                scrollView.contentInsetAdjustmentBehavior = .never
            }
        }
        
        init(of viewController: UIViewController) {
            
            if let snapshot = viewController.view.snapshotView(afterScreenUpdates: true) {
                view = snapshot
                viewController.view.addSubview(snapshot)
                snapshot.pin(to: viewController.view, [.bottom, .centerX, .width, .height])
            }
            
            func suspendContentInsetAdjustmentBehavior(in subviews: [UIView]) {
                for view in subviews {
                    if let scrollView = view as? UIScrollView {
                        scrollViewSnapshots.append(ScrollViewSnapshot(with: scrollView))
                    }
                    suspendContentInsetAdjustmentBehavior(in: view.subviews)
                }
            }
            
            if let nvc = viewController as? UINavigationController, let subviews = nvc.viewControllers.last?.view.subviews {
                suspendContentInsetAdjustmentBehavior(in: subviews)
            } else {
                suspendContentInsetAdjustmentBehavior(in: viewController.view.subviews)
            }
        }
        
        func reset() {
            
            view?.removeFromSuperview()
            
            for snapshot in scrollViewSnapshots {
                snapshot.scrollView?.contentInsetAdjustmentBehavior = snapshot.adjustmentBehavior
                snapshot.scrollView?.contentOffset.y = snapshot.offsetY
            }
        }
    }
    
    private static let scaleFactor: CGFloat = 0.05
    public private(set) var cardViews = [CardView]()
    private weak var topLevelViewController: UIViewController?
    private var snapshots = NSMapTable<UIViewController, Snapshot>(keyOptions: [.weakMemory], valueOptions: [.strongMemory])
    
    public init(topLevelViewController: UIViewController? = nil) {
        self.topLevelViewController = topLevelViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Actions
    
    @objc private func coverViewTapped() {
        
        guard !isIPad else { return }
        guard let cardView = cardViews.last else { return }
        guard cardView.viewController?.cardViewContentDelegate?.isBackgroundDismissable ?? true else { return }
        cardView.animateOut()
    }

    public func present(_ viewController: UIViewController, options: [Option] = []) {

        if cardViews.count == 0 {
            view.superview?.alpha = 1.0
        }
        
        let previousVC = cardViews.count == 0 ? topLevelViewController : cardViews.last?.viewController
        
        if let vc = previousVC {
            snapshots.setObject(Snapshot(of: vc), forKey: vc)
        }
        
        let coverView = newCoverView(dark: options.contains(.darkBackground))
        let cardView = CardView(viewController: viewController,
                                coverView: coverView,
                                showHandle:options.contains(.showHandle))
        cardView.delegate = self
        
        let heightConstraint = viewController.cardViewContentDelegate?.heightConstraint(for: cardView.heightAnchor)
        let topPadding = viewController.cardViewContentDelegate?.topPadding
        let useCardTopPadding = !options.contains(.isFullscreen) || options.contains(.showHandle)
        
        let cardViewConstraints = cardView.cardViewConstraints(in: view,
                                                               with: heightConstraint,
                                                               useTopPadding: useCardTopPadding)
        cardView.yConstraint = cardViewConstraints[1]
        
        view.addSubview(coverView)
        view.addSubview(cardView)
        
        NSLayoutConstraint.activate(cardViewConstraints)
        NSLayoutConstraint.activate(coverView.coverViewConstraints(in:view))
        
        contain(viewController, constraintBlock:{ (childView) -> ([NSLayoutConstraint]) in
            cardView.addSubview(childView)
            return childView.viewControllerConstraints(in:cardView, with:topPadding)
        })

        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        cardViews.append(cardView)
        
        cardView.setBackgroundColor()
        cardView.yConstraint?.constant = cardView.bounds.size.height
        cardView.animateIn()
    }

    func dismissModalCard(with viewController:UIViewController, completion: (() -> Void)? = nil) {
        
        var found = false
        
        for cardView in cardViews {
            
            guard let vc = cardView.viewController else { continue }
            
            if let nvc = vc as? UINavigationController, let givenVCNVC = viewController.navigationController, givenVCNVC == nvc {
                found = true
            }
            else if cardView.viewController == viewController {
                found = true
            }
            
            guard found else { continue }
            
//            if let firstResponder = cardView.findFirstResponder() {
//                firstResponder.resignFirstResponder()
//            }
            
            cardView.animateOut(completion: completion)
            break
        }
    }
 
    // MARK: - Accessors

    private func newCoverView(dark:Bool) -> UIView {
        
        let view = UIView(frame:.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.0
        view.isUserInteractionEnabled = true
        
        if dark {
            view.backgroundColor = UIColor(white:0.0,alpha:0.6)
        }
        
        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(coverViewTapped))
        view.addGestureRecognizer(tapGestureRecogniser)
        
        return view
    }
}

@available(iOS 11.0, *)
extension CardViewController: CardViewDelegate {
    
    public func cardViewWillAppear(_ cardView: CardView) -> () -> Void {
    
        return { [weak self] in
            
            guard let `self` = self else { return }

            let scale = 1.0 - CardViewController.scaleFactor

            if self.cardViews.count == 1 {

                self.topLevelViewController?.view.superview?.transform = CGAffineTransform(scaleX: scale, y: scale)
                self.topLevelViewController?.view.superview?.layer.cornerRadius = CardView.cornerRadius

            } else {

                let cardView = self.cardViews[self.cardViews.count - 2]
                cardView.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
    }
    
    public func cardViewWasPanned(_ cardView: CardView, percentage: CGFloat) {
        
        guard percentage > 0.0 && percentage <= 1.0 else { return }
        let scale = 1.0 - CardViewController.scaleFactor + (CardViewController.scaleFactor * percentage)

        if cardViews.count == 1 {
            topLevelViewController?.view.superview?.transform = CGAffineTransform(scaleX: scale, y: scale)
            topLevelViewController?.view.superview?.layer.cornerRadius = CardView.cornerRadius - (CardView.cornerRadius * percentage)
        }
        else if cardViews.count > 1 {
            cardViews[cardViews.count - 2].transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    public func cardViewWillDismiss(_ cardView: CardView) -> () -> Void {
        
        return { [weak self] in
            
            guard let `self` = self else { return }

            if self.cardViews.count == 1 {
                self.topLevelViewController?.view.superview?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.topLevelViewController?.view.superview?.layer.cornerRadius = 0.0
            } else {
                let cardView = self.cardViews[self.cardViews.count - 2]
                cardView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }
    }
    
    public func cardViewDidDismiss(_ cardView: CardView) {
        
        guard let index = cardViews.index(of: cardView) else {
            //TODO: assert
            return
        }
        
        cardViews.remove(at: index)
        
        if let vc = cardView.viewController {
            dismissContained(vc)
        }
        
        cardView.coverView?.removeFromSuperview()
        cardView.removeFromSuperview()
        
        if let previousVC = cardViews.count == 0 ? topLevelViewController : cardViews.last?.viewController {
            snapshots.object(forKey: previousVC)?.reset()
            snapshots.removeObject(forKey: previousVC)
        }

        if cardViews.count == 0 {
            view.superview?.alpha = 0.0
            snapshots.removeAllObjects()
        }
    }
}

extension CardView {
    
    func cardViewConstraints(in superview: UIView, with heightConstraint: NSLayoutConstraint?, useTopPadding: Bool) -> [NSLayoutConstraint] {
        
        let x = centerXAnchor.constraint(equalTo:superview.centerXAnchor)
        let y = bottomAnchor.constraint(equalTo:superview.bottomAnchor, constant:bounds.size.height)
        let w = isIPad ? widthAnchor.constraint(equalToConstant: CardView.iPadWidth) : widthAnchor.constraint(equalTo:superview.widthAnchor)
        
        let heightConstant = useTopPadding ? CardView.bottomPadding - CardView.topPadding : CardView.bottomPadding

        guard let heightConstraint = heightConstraint else {
            let h = heightAnchor.constraint(equalTo:superview.heightAnchor, constant:heightConstant)
            return [x,y,w,h]
        }
        
        heightConstraint.constant += heightConstant
        
        return [x,y,w,heightConstraint]
    }
}

fileprivate extension UIView {
    
    func viewControllerConstraints(in superview: CardView, with topPadding: CGFloat?) -> [NSLayoutConstraint] {
        
        let x = centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        let y = topAnchor.constraint(equalTo: superview.topAnchor, constant: topPadding ?? 0.0)
        let y2 = bottomAnchor.constraint(equalTo: superview.bottomAnchor,constant: -CardView.bottomPadding)
        let w = widthAnchor.constraint(equalTo: superview.widthAnchor)
        
        return [x,y,y2,w]
    }
    
    func coverViewConstraints(in superview: UIView) -> [NSLayoutConstraint] {
        
        let x = centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        let y = centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        let w = widthAnchor.constraint(equalTo: superview.widthAnchor)
        let h = heightAnchor.constraint(equalTo: superview.heightAnchor)
        
        return [x,y,w,h]
    }
}

extension UIViewController {
    
    var cardViewContentDelegate: CardViewContentDelegate? {
        
        if let delegate = self as? CardViewContentDelegate {
            return delegate
        } else if let nvc = self as? UINavigationController,
            let delegate = nvc.viewControllers.last as? CardViewContentDelegate {
            return delegate
        } else {
            for vc in children { if let delegate = vc as? CardViewContentDelegate { return delegate } }
        }
        
        return nil
    }
}
