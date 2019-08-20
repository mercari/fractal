//
//  TabBarController.swift
//  TestApp
//
//  Created by anthony on 20/08/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

protocol TabBarControllerBrand {
    func applyBrand(to tabBar: UITabBar)
}

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let brand = BrandingManager.brand as? TabBarControllerBrand {
            brand.applyBrand(to: tabBar)
        }
    }
}
