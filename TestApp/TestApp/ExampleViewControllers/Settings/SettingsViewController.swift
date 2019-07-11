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

    private let darkModeObserved = Observed<Bool>(false)

    override func viewDidLoad() {
        title = "Settings"
        super.viewDidLoad()
        view.backgroundColor = .background()
        view.addSubview(bounceImageView)
        view.sendSubviewToBack(bounceImageView)
        bounceImageView.pin(to: view, [.top, .centerX, .width, .height(asConstant: 400.0)])
        setSections()
        reload()
    }

    private func setSections() {
        dataSource.sections = [
            spacing(400.0),
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

    // MARK: - Properties

    private var bounceImageView: BounceScaleImageView = {
        let imageView = BounceScaleImageView(imageHeight: 400.0, withBlur: false)
        imageView.image = .image(.logo)
        return imageView
    }()
}
