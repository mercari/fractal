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
        cardExample,
        yoga,
        settings
    }

    static var shared: NavigationRouter!

    private let rootNavigationController: NavigationController
    private let cardViewController: CardViewController

    private var currentNavigationController: NavigationController {
        
        if let cardNavigationController = cardViewController.cardViews.last?.viewController as? NavigationController {
            return cardNavigationController
        }
        
        return rootNavigationController
    }

    static func new(_ rootNavigationController: NavigationController, _ cardViewController: CardViewController) {
        shared = NavigationRouter(rootNavigationController, cardViewController)
    }

    private init(_ rootNavigationController: NavigationController, _ cardViewController: CardViewController) {
        self.rootNavigationController = rootNavigationController
        self.cardViewController = cardViewController
    }

    // MARK: - Public Actions

    func navigationOptionSelected(_ option: String) {
        guard let intent = Intent(rawValue: option) else { print("No navigation intent for \(option)"); return }
        perform(intent)
    }

    func yogaEventTapped(_ event: YogaSectionOption) {
        presentYogaDetail(event)
    }
    
    // MARK: - Private

    private func perform(_ intent: NavigationRouter.Intent) {

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
        case .yoga:
            presentYogaExample()
        case .settings:
            presentSettings()
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
        let nav = NavigationController(rootViewController: viewController)
        cardViewController.present(nav, options: [.darkBackground, .isFullscreen])
    }
    
    private func presentYogaExample() {
        let viewController = YogaViewController()
        currentNavigationController.pushViewController(viewController, animated: true)
    }
    
    private func presentYogaDetail(_ event: YogaSectionOption) {
        guard let event = event as? YogaEvent else { return }
        let viewController = YogaDetailViewController(event: event)
        currentNavigationController.pushViewController(viewController, animated: true)
    }

    private func presentSettings() {
        let viewController = SettingsViewController()
        currentNavigationController.pushViewController(viewController, animated: true)
    }
}



extension NavigationRouter: CardViewContentDelegate {
    
    var isDraggable: Bool { return true }
}
