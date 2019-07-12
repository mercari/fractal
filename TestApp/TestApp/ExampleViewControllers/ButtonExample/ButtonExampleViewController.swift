//
//  ButtonExampleViewController.swift
//  DesignSystemApp
//
//  Created by Anthony Smith on 12/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import DesignSystem

class ButtonExampleViewController: UIViewController, SectionBuilder {

    var presenter: ButtonExamplePresenter!
    var sectionTableViewController: SectionTableViewController!

    private var reload: () -> Void {
        return { [weak self] in
            guard let `self` = self else { return }
            self.sectionTableViewController.reload()
        }
    }

    override func viewDidLoad() {
        title = "ButtonExampleVC"
        super.viewDidLoad()
        view.backgroundColor = .background
        DependencyRegistry.shared.prepare(viewController: self)

        sectionTableViewController.dataSource.sections = [
            headline("Single Buttons"),
            spacing(),
            singleButton("Primary", tappedClosure: presenter.primaryButtonTapped),
            spacing(),
            singleButton("Secondary", style: .secondary, tappedClosure: presenter.secondaryButtonTapped),
            spacing(),
            singleButton("Attention", style: .attention, tappedClosure: presenter.attentionButtonTapped),
            spacing(),
            singleButton("Toggle", style: .toggle, tappedClosure: presenter.toggleButtonTapped, selectedClosure: presenter.toggleButtonSelected),
            //spacing(),
            //seperator(),
            //buttonOptions(["Main Option", "Option 2", "Alternative Option 3"], selectionClosure: presenter.optionsButtonTapped)
        ]
        sectionTableViewController.reload()
    }

    func inject(presenter: ButtonExamplePresenter, sectionTableViewController: SectionTableViewController) {
        presenter.didChange = reload
        self.contain(sectionTableViewController)
        self.presenter = presenter
        self.sectionTableViewController = sectionTableViewController
    }
}
