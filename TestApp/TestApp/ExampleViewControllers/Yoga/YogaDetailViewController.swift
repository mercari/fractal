//
//  YogaDetailViewController.swift
//  TestApp
//
//  Created by anthony on 26/08/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

class YogaDetailViewController: SectionTableViewController, SectionBuilder {

    var presenter: YogaDetailPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        DependencyRegistry.shared.prepare(viewController: self)
    }

    func inject(_ presenter: YogaDetailPresenter) {
        self.presenter = presenter
    }
    
    private func setSections() {
        dataSource.sections = [headline("Popular Lessons"),
                               headline("New Lessons"),
                               
                               
                               spacing(100.0, backgroundColorKey: .secondary)
        
        
                                
        ]
    }
}
