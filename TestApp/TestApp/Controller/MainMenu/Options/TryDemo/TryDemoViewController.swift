//
//  TryDemoViewController.swift
//  DesignSystemApp
//
//  Created by anthony on 12/04/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import UIKit
import DesignSystem


class TryDemoViewController: UIViewController, SectionBuilder {

    let sectionTableViewController = SectionTableViewController()

    override func viewDidLoad() {
        title = "Demo"
        super.viewDidLoad()
        view.backgroundColor = .background()

        self.contain(sectionTableViewController)
        sectionTableViewController.dataSource.sections = [
            headline("Demo Sections"),
            group([
                information("Today's date", detailClosure: { BrandingManager.dateManager.string(from: Date()) }),
                navigationOptions({ [weak self] in self?.staticNavOptions ?? [] }, selectionClosure: navigationSelectionClosure)
                ]),
            spacing(),
            singleButton("Submit", tappedClosure: primaryButtonTapped),
            spacing(),
            singleButton("Cancel", style: .secondary, tappedClosure: secondaryButtonTapped)
        ]
        sectionTableViewController.reload()
    }

    // MARK: - Properties

    var staticNavOptions: [NavigationExampleEntity] = {
        let options = [NavigationExampleEntity.init(title: "Home", intent: "home_push"),
                       NavigationExampleEntity.init(title: "Search", intent: "search_push"),
                       NavigationExampleEntity.init(title: "Settings", intent: "settings_push")]
        return options
    }()

    private var navigationSelectionClosure: (Int, NavigationOption) -> Void {
        return { (_, option) in
            guard let intent = option.intent else { Assert("No intent for option \(option.title)"); return }
            NavigationRouter.shared.perform(intent)
        }
    }

    var primaryButtonTapped: () -> Void {
        return { () in
            print("TODO: Forward action for primary button")
        }
    }

    var secondaryButtonTapped: () -> Void {
        return { () in
            print("TODO: Forward action for secondary button")
        }
    }
}
