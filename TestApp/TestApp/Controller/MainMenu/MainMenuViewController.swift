//
//  MainMenuViewController.swift
//  DesignSystemApp
//
//  Created by anthony on 21/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit
import DesignSystem

class MainMenuViewController: UIViewController, SectionBuilder {

    private var sectionController: SectionController!
    private var presenter: MainMenuPresenter!

    override func viewDidLoad() {
        title = "Design System Sandbox"
        super.viewDidLoad()
        view.backgroundColor = .background()
        DependencyRegistry.shared.prepare(viewController: self)
        sectionController.dataSource.sections = [
            group([
                navigationOptions(presenter.systemOptions, style: .default, selectionClosure: selection)
                ]),
            seperator(),
            group([navigationOptions(presenter.exampleOptions, style: .default, selectionClosure: selection)]),
            seperator(),
            group([navigationOptions(presenter.pages, style: .default, selectionClosure: selection)]),
        ]
        sectionController.reload()
    }

    func inject(presenter: MainMenuPresenter, sectionController: SectionViewController) {
        self.contain(sectionController)
        self.presenter = presenter
        self.sectionController = sectionController
    }

    var selection: (Int, NavigationOption) -> Void {
        return { [weak self] (index, option)  in
            guard let `self` = self else { return }
            self.presenter.selection(index, option, self)
        }
    }
}
