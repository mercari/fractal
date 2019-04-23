//
//  TabBarController.swift
//  DesignSystemApp
//
//  Created by anthony on 09/04/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {

    init() {
        super.init(nibName: nil, bundle: nil)
        self.setViewControllers([feed(), forYou(), sell(), merpay(), myPage()], animated: false)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func feed() -> UINavigationController {
        let vc = UIViewController()
        vc.title = "Feed"
        let nvc = UINavigationController(rootViewController: vc)
        return nvc
    }

    private func forYou() -> UINavigationController {
        let vc = UIViewController()
        vc.title = "For You"
        let nvc = UINavigationController(rootViewController: vc)
        return nvc
    }

    private func sell() -> UINavigationController {
        let vc = UIViewController()
        vc.title = "Sell"
        let nvc = UINavigationController(rootViewController: vc)
        return nvc
    }

    private func merpay() -> UINavigationController {
        let vc = UIViewController()
        vc.title = "Merpay"
        let nvc = UINavigationController(rootViewController: vc)
        return nvc
    }

    private func myPage() -> UINavigationController {
        let vc = MyPageViewController()
        vc.title = "My Page"
        let nvc = UINavigationController(rootViewController: vc)
        return nvc
    }

    private static func generateTabBarItem(title: String?, image: UIImage?, selectedImage: UIImage?) -> UITabBarItem {
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
        return tabBarItem
    }
}
