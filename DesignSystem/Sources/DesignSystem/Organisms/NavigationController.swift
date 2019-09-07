//
//  NavigationController.swift
//  TestApp
//
//  Created by anthony on 20/08/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation

public protocol NavigationControllerBrand {
    func applyBrand(to navigationBar: UINavigationBar)
}

public protocol BrandUpdateable: UIViewController { // TODO: maybe doesn't have to be a vc
    func brandWasUpdated()
}

public class NavigationController: UINavigationController {

    private var notificationObject: NSObjectProtocol?

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    override public init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    deinit {
        if let observer = notificationObject {
            NotificationCenter.default.removeObserver(observer)
        }
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        applyBrand()
    }

    private func setup() {
        notificationObject = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: BrandingManager.didChange), object: nil, queue: nil) { [weak self] (_) in
            guard let `self` = self else { return }
            self.applyBrand()
            self.updateViewControllers()
        }
    }

    private func applyBrand() {
        guard let brand = BrandingManager.brand as? NavigationControllerBrand else {
            print("BrandingManager.brand does not conform to NavigationControllerBrand")
            return
        }
        brand.applyBrand(to: navigationBar)
    }
    
    private func updateViewControllers() {
        
        func updateIfPossible(_ vc: UIViewController) {
            if let updateable = vc as? BrandUpdateable { updateable.brandWasUpdated() }
            for vc in vc.children { updateIfPossible(vc) }
        }
        
        for vc in viewControllers {
            updateIfPossible(vc)
        }
    }
}
