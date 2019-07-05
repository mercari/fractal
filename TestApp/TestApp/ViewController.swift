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
        view.backgroundColor = .black
        let vc = MainMenuViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.prefersLargeTitles = true
        let cardViewController = CardViewController(topLevelViewController: navigationController)

        contain(navigationController)
        contain(cardViewController)
        cardViewController.view.superview?.alpha = 0.0 //TODO: find a way to put this inside CardViewController

        NavigationRouter.new(navigationController, cardViewController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

