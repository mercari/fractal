//
//  NavigationExampleViewController.swift
//  DesignSystemApp
//
//  Created by anthony on 19/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit
import DesignSystem


class NavigationExampleViewController: UIViewController, SectionBuilder {

    private var sectionViewController: SectionController!
    private var presenter: NavigationExamplePresenter!
    private enum State { case initial, toggled }
    private var renderedState: State?
    private var state: State { return presenter.buttonIsSelected() ? .toggled : .initial }

    private var didChange: () -> Void {
        return { [weak self] in
            guard let `self` = self else { return }
            if self.renderedState != self.state {
                self.renderedState = self.state
                self.setSections()
            }
            self.sectionViewController.reload()
        }
    }

    override func viewDidLoad() {
        title = "NavigationExampleVC"
        super.viewDidLoad()
        view.backgroundColor = .background()
        DependencyRegistry.shared.prepare(viewController: self)
        setSections()
        didChange()
    }

    func inject(presenter: NavigationExamplePresenter, sectionController: SectionViewController) {
        self.sectionViewController = sectionController
        self.contain(sectionController)
        self.presenter = presenter
        self.presenter.didChange = didChange
    }

    private func setSections() {
        sectionViewController.dataSource.sections = [
            spacing(),
            singleButton("Tap to change content", style: .toggle, tappedClosure: presenter.buttonTapped, selectedClosure: presenter.buttonIsSelected),
            headline("Navigation Options"),
            group([
                navigationOptions(presenter.defaultOptions, selectionClosure: selectionClosure),
                navigationOptions(presenter.detailOptions, style: .detail, selectionClosure: selectionClosure),
                navigationOptions(presenter.informationOptions, style: .information(constant: 120.0), selectionClosure: selectionClosure)
                ]),
            help("Help Center", selectionClosure: { print("Push to help center") }),
            navigationGroup("Group Options", options: presenter.groupOptions, selectionClosure: selectionClosure),
            headline("DateEntryView"),
            group([
                dateEntries(presenter.dateExampleOptions, selectionClosure: dateSelectionClosure),
                dateEntries(presenter.dateExampleOptions, style: .disclosureText, selectionClosure: dateSelectionClosure)
                ])
        ]
    }

    private var selectionClosure: (Int, NavigationOption) -> Void {
        return { (_, option) in
            guard let intent = option.intent else { Assert("No intent for option \(option.title)"); return }
            NavigationRouter.shared.perform(intent)
        }
    }

    private var dateSelectionClosure: (Int) -> Void {
        return { (index) in
            print("selected item \(index)")
        }
    }
}
