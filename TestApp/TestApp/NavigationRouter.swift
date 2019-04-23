//
//  NavigationRouter.swift
//  DesignSystemApp
//
//  Created by anthony on 21/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit

class NavigationRouter {

    enum Intent: String {
        case palette,
        typography,
        size,
        navigationExample,
        demo,
        buttonExample,
        selectionExample,
        pages,
        filteringExample
    }

    static var shared: NavigationRouter!

    private let rootNavigationController: UINavigationController

    static func new(_ rootNavigationController: UINavigationController) {
        shared = NavigationRouter(rootNavigationController)
    }

    private init(_ rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
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
        case .navigationExample:
            pushNavigationExample()
        case .buttonExample:
            pushButtonExample()
        case .selectionExample:
            pushSelectionExample()
        case .pages:
            pushPages()
        case .demo:
            pushDemo()
        case .filteringExample:
            pushFilteringExample()
        }
    }

    // MARK: - Routing

    private func pushDemo() {
        let viewController = TryDemoViewController()
        rootNavigationController.pushViewController(viewController, animated: true)
    }

    private func pushPalette() {
        let viewController = ColorPaletteViewController()
        rootNavigationController.pushViewController(viewController, animated: true)
    }

    private func pushTypography() {
        let viewController = TypographyViewController()
        rootNavigationController.pushViewController(viewController, animated: true)
    }

    private func pushSizes() {
        let viewController = SizeOptionsViewController()
        rootNavigationController.pushViewController(viewController, animated: true)
    }

    private func pushButtonExample() {
        let viewController = ButtonExampleViewController()
        rootNavigationController.pushViewController(viewController, animated: true)
    }

    private func pushNavigationExample() {
        let viewController = NavigationExampleViewController()
        rootNavigationController.pushViewController(viewController, animated: true)
    }

    private func pushSelectionExample() {
        let viewController = SelectionAndInfoViewController()
        rootNavigationController.pushViewController(viewController, animated: true)
    }

    private func pushPages() {
        let viewController = TabBarController()
        rootNavigationController.pushViewController(viewController, animated: true)
    }

    private func pushFilteringExample() {
        let viewController = FilteringTableViewController()
        rootNavigationController.pushViewController(viewController, animated: true)
    }
}
