//
//  YogaViewController.swift
//  TestApp
//
//  Created by anthony on 26/08/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

class YogaViewController: SectionTableViewController {

    var presenter: YogaPresenter!

    override func viewDidLoad() {
        title = "TypographyVC"
        super.viewDidLoad()
        view.backgroundColor = .background
        DependencyRegistry.shared.prepare(viewController: self)

    }

    func inject(_ presenter: YogaPresenter) {
        self.presenter = presenter
    }

    private func setSections() {

    }
}
