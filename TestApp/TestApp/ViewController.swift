//
//  ViewController.swift
//  TestApp
//
//  Created by anthony on 23/04/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import UIKit
import DesignSystem

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc = MainMenuViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        contain(navigationController)

        NavigationRouter.new(navigationController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

