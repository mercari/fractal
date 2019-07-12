//
//  TypographyViewController.swift
//  DesignSystemApp
//
//  Created by anthony on 16/01/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import DesignSystem

class TypographyViewController: UIViewController, SectionBuilder {

    private var sectionController: SectionController!
    private var viewModel: TypographyViewModel!

    override func viewDidLoad() {
        title = "TypographyVC"
        super.viewDidLoad()
        view.backgroundColor = .background
        DependencyRegistry.shared.prepare(viewController: self)

        let sliderSection = slider(steps: Float(viewModel.accessibilityOptions.count - 1),
                                   snapStyle: .always,
                                   valueClosure: viewModel.accessibilityTestValue,
                                   didChangeClosure: viewModel.testValueChanged)

        sectionController.dataSource.sections = [group([switchOption("Accessibility Test", observedBool: viewModel.isTesting),
                                                        sliderSection], middleDivider: divider(.indentedBoth(.keyline))),
                                                 typographyOptions(viewModel.optionsClosure)]
        viewModel.fetch()
    }

    func inject(_ viewModel: TypographyViewModel, sectionController: SectionViewController) {
        self.contain(sectionController)
        viewModel.didChange = { (indexes) in
            sectionController.reloadSections(at: indexes)
        }
        self.sectionController = sectionController
        self.viewModel = viewModel
    }
}
