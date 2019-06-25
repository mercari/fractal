//
//  MainMenuViewController.swift
//  DesignSystemApp
//
//  Created by anthony on 21/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import DesignSystem

class MainMenuViewController: UIViewController, SectionBuilder {

    private var sectionViewController: SectionTableViewController!
    private var presenter: MainMenuPresenter!

    var cardHeight: CGFloat = 500.0
    
    override func viewDidLoad() {
        title = "Design System Sandbox"
        super.viewDidLoad()
        view.backgroundColor = .background()
        DependencyRegistry.shared.prepare(viewController: self)
        sectionViewController.dataSource.sections = [
            headline(BrandingManager.brand.id),
            group([
                navigationOptions(presenter.systemOptions, style: .default, selectionClosure: selection)
                ]),
            seperator(),
            group([
                navigationOptions(presenter.exampleOptions, style: .default, selectionClosure: selection)
                ])
        ]
        sectionViewController.reload()
    }

    func inject(presenter: MainMenuPresenter, sectionViewController: SectionTableViewController) {
        self.contain(sectionViewController)
        self.presenter = presenter
        self.sectionViewController = sectionViewController
    }

    var selection: (Int, NavigationOption) -> Void {
        return { [weak self] (index, option)  in
            guard let `self` = self else { return }
            self.presenter.selection(index, option, self)
        }
    }
}

extension MainMenuViewController: CardViewContentDelegate {
    var contentScrollView: UIScrollView? { return sectionViewController.tableView }
    var isBackgroundDismissable: Bool { return true }
    func heightConstraint(for cardViewHeightAnchor: NSLayoutDimension) -> NSLayoutConstraint? {
        return cardViewHeightAnchor.constraint(equalToConstant: cardHeight)
    }
}
