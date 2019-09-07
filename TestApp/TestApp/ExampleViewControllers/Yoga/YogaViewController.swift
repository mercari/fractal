//
//  YogaViewController.swift
//  TestApp
//
//  Created by anthony on 26/08/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

class YogaViewController: SectionTableViewController, SectionBuilder {

    var presenter: MockYogaPresenter!

    override func viewDidLoad() {
        title = "Yoga"
        super.viewDidLoad()
        view.backgroundColor = .background
        DependencyRegistry.shared.prepare(viewController: self)
    }

    func inject(_ presenter: MockYogaPresenter) {
        self.presenter = presenter
        setSections()
        reload()
    }
    
    private func setSections() {
        dataSource.sections = [
            //Phase 1
        ]
    }
}
