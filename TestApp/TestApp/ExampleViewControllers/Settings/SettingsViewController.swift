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

    private let darkMode = Observable<Bool>(BrandingManager.isDarkModeBrand)
    private var blockObservation: Bool = false
    
    override func viewDidLoad() {
        title = "Settings"
        super.viewDidLoad()
        setStyle()
        setSections()
        reload()

        darkMode.addObserver(self) { [weak self] (isOn) in
            guard let `self` = self else { return }
            guard !self.blockObservation else { return }
            BrandingManager.set(brand: isOn ? FractalDarkBrand() : FractalBrand())
        }
    }

    private func setStyle() {
        view.backgroundColor = .background
    }

    private func setSections() {
        dataSource.sections = [
            image(.logo, heightType: .custom(200.0)),
            headline("Alternate Icons"),
            iconSelectionCarousel(),
            group([
                switchOption("Dark Mode", observedBool: darkMode),
                information("Version", detailClosure: { Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "-1.0" })
                ]),
            spacing(32.0),
            singleButton("Yoga Brand", tappedClosure: { [weak self] in self?.applyYogaBranding() }),
            spacing(),
            singleButton("Remove All Branding", tappedClosure: { [weak self] in self?.removeBranding() })
        ]
    }

    private func applyYogaBranding() {
        blockObservation = true
        darkMode.value = false
        blockObservation = false
        BrandingManager.set(brand: YogaBrand())
    }
    
    private func removeBranding() {
        blockObservation = true
        darkMode.value = false
        blockObservation = false
        BrandingManager.set(brand: DefaultBrand())
    }
}

extension SettingsViewController: BrandUpdateable {
    func brandWasUpdated() {
        // TODO: add wipe
        setStyle()
    }
}

