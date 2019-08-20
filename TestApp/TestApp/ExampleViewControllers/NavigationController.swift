//
//  NavigationController.swift
//  TestApp
//
//  Created by anthony on 20/08/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

protocol NavigationControllerBrand {
    func applyBrand(to navigationBar: UINavigationBar)
}

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let brand = BrandingManager.brand as? NavigationControllerBrand {
            brand.applyBrand(to: navigationBar)
        }
    }
}
