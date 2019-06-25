//
//  NavigationRouter.swift
//  DesignSystemApp
//
//  Created by anthony on 21/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit
import DesignSystem

class NavigationRouter {

    enum Intent: String {
        case palette,
        typography,
        size,
        buttonExample,
        selectionExample,
        filteringExample,
        cardExample
    }

    static var shared: NavigationRouter!

    private let rootNavigationController: UINavigationController
    private let cardViewController: CardViewController

    private var currentNavigationController: UINavigationController {
        
        if let cardNavigationController = cardViewController.cardViews.last?.viewController as? UINavigationController {
            return cardNavigationController
        }
        
        return rootNavigationController
    }

    static func new(_ rootNavigationController: UINavigationController, _ cardViewController: CardViewController) {
        shared = NavigationRouter(rootNavigationController, cardViewController)
    }

    private init(_ rootNavigationController: UINavigationController, _ cardViewController: CardViewController) {
        self.rootNavigationController = rootNavigationController
        self.cardViewController = cardViewController
    }

    func perform(_ rawIntent: String) {
        guard let intent = Intent(rawValue: rawIntent) else { print("No navigation intent for \(rawIntent)"); return }
        perform(intent)
    }

    func perform(_ intent: NavigationRouter.Intent) {

        switch intent {
        case .palette:
            pushPalette()
        case .typography:
            pushTypography()
        case .size:
            pushSizes()
        case .buttonExample:
            pushButtonExample()
        case .selectionExample:
            pushSelectionExample()
        case .filteringExample:
            pushFilteringExample()
        case .cardExample:
            presentCardExample()
        }
    }

    // MARK: - Routing

    private func pushPalette() {
        let viewController = ColorPaletteViewController()
        currentNavigationController.pushViewController(viewController, animated: true)
    }

    private func pushTypography() {
        let viewController = TypographyViewController()
        currentNavigationController.pushViewController(viewController, animated: true)
    }

    private func pushSizes() {
        let viewController = SizeOptionsViewController()
        currentNavigationController.pushViewController(viewController, animated: true)
    }

    private func pushButtonExample() {
        let viewController = ButtonExampleViewController()
        currentNavigationController.pushViewController(viewController, animated: true)
    }

    private func pushSelectionExample() {
        let viewController = SelectionAndInfoViewController()
        currentNavigationController.pushViewController(viewController, animated: true)
    }

    private func pushFilteringExample() {
        let viewController = FilteringTableViewController()
        currentNavigationController.pushViewController(viewController, animated: true)
    }
    
    private func presentCardExample() {
        let viewController = MainMenuViewController()
        viewController.cardHeight = max(500.0, 800.0 - (100.0 * CGFloat(cardViewController.cardViews.count)))
        let nav = UINavigationController(rootViewController: viewController)
        cardViewController.present(nav, options: [.darkBackground, .isFullscreen])
    }
}


extension NavigationRouter: CardViewContentDelegate {
    
    var isDraggable: Bool { return true }
}
