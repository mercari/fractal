//
//  DependencyRegistry.swift
//  DesignSystemApp
//
//  Created by anthony on 14/12/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import DesignSystem

class DependencyRegistry {
    static let shared = DependencyRegistry()

    func prepare(viewController: ButtonExampleViewController) {
        let presenter = ButtonExamplePresenter()
        let vc = SectionTableViewController()
        viewController.inject(presenter: presenter, sectionTableViewController: vc)
    }

    func prepare(viewController: MainMenuViewController) {
        let presenter = MainMenuPresenter()
        viewController.inject(presenter: presenter)
    }

    func prepare(viewController: ColorPaletteViewController) {
        let vc = SectionCollectionViewController()
        viewController.inject(sectionController: vc)
    }

    func prepare(viewController: TypographyViewController) {
        let vc = SectionCollectionViewController()
        let viewModel = TypographyViewModel()
        viewController.inject(viewModel, sectionController: vc)
    }

    func prepare(viewController: SizeOptionsViewController) {
        let vc = SectionTableViewController()
        viewController.inject(sectionController: vc)
    }

    func prepare(viewController: SelectionAndInfoViewController) {
        let vc = SectionTableViewController()
        viewController.inject(sectionController: vc)
    }
}
