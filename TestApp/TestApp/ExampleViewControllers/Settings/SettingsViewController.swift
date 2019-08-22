//
//  SettingsViewController.swift
//  TestApp
//
//  Created by anthony on 10/07/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

class SettingsViewController: SectionTableViewController, SectionBuilder {

    private let darkModeObserved = Observable<Bool>(false)

    override func viewDidLoad() {
        title = "Settings"
        super.viewDidLoad()
        view.backgroundColor = .background
        setSections()
        reload()
    }

    private func setSections() {
        dataSource.sections = [
            image(.logo, heightType: .custom(200.0)),
            headline("Alternate Icons"),
            iconSelectionCarousel(),
            group([
                switchOption("Dark Mode", observedBool: darkModeObserved),
                information("Version", detailClosure: { "0.2" })
                ]),
            spacing(32.0),
            singleButton("Remove All Branding", tappedClosure: { [weak self] in self?.removeBranding() })
        ]
    }

    private func removeBranding() {

    }
}
