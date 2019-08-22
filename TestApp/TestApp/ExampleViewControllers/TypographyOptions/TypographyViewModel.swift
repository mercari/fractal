//
//  TypographyViewModel.swift
//  DesignSystemApp
//
//  Created by anthony on 23/01/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import DesignSystem

class TypographyViewModel {

    private var options = [BrandingManager.Typography]() { didSet { didChange?([1]) }}
    var didChange: (([Int]) -> Void)?
    let isTesting: Observable<Bool> = Observable<Bool>(UserDefaults.standard.bool(forKey: BrandingManager.contentSizeOverrideKey))

    init() {
        isTesting.addObserver(self) { [weak self] (testing) in
            guard let `self` = self else { return }
            // TODO: probably wrap below up in the DesignSystem and don't expose the keys directly
            UserDefaults.standard.set(testing, forKey: BrandingManager.contentSizeOverrideKey)
            NotificationCenter.default.post(name: Notification.Name(rawValue: BrandingManager.didChange), object: nil)
            self.didChange?([1])
        }
    }

    func fetch() {
        fetchTypographyOptions()
    }

    private func fetchTypographyOptions() {
        self.options = (BrandingManager.brand as? BrandTest)?.allTypographyCases ?? []
    }

    // MARK: - Properties

    var accessibilityOptions: [UIContentSizeCategory] {
         return [.extraSmall,
                .small,
                .medium,
                .large,
                .extraLarge,
                .extraExtraLarge,
                .extraExtraExtraLarge,
                .accessibilityMedium,
                .accessibilityLarge,
                .accessibilityExtraLarge,
                .accessibilityExtraExtraLarge,
                .accessibilityExtraExtraExtraLarge]
    }

    var accessibilityTestValue: () -> (Float) {
        return { [weak self] in
            guard let `self` = self else { return 0.0 }
            let index = self.accessibilityOptions.firstIndex(of: BrandingManager.contentSizeCategory) ?? 0
            return Float(index)
        }
    }

    var testValueChanged: (Float) -> Void {
        return { [weak self] (value) in
            guard let `self` = self else { return }
            // TODO: probably wrap below up in the DesignSystem and don't expose the keys directly
            UserDefaults.standard.set(self.accessibilityOptions[Int(value)].rawValue, forKey: BrandingManager.contentSizeOverrideValueKey)
            NotificationCenter.default.post(name: Notification.Name(rawValue: BrandingManager.didChange), object: nil)

            if self.isTesting.value == false {
                self.isTesting.value = true
            } else {
                self.didChange?([])
            }
        }
    }

    var optionsClosure: () -> ([BrandingManager.Typography]) {
        return { [weak self] in
            guard let `self` = self else { return [] }
            return self.options
        }
    }
}
