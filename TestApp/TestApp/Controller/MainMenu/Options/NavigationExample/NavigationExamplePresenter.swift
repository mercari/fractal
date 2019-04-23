//
//  NavigationExampleViewModel.swift
//  DesignSystemApp
//
//  Created by anthony on 19/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import DesignSystem
import UIKit


class NavigationExamplePresenter  {

    var didChange: (() -> Void)?

    private let interactor = NavigationExampleInteractor()

    // MARK: - Closures

    var buttonTapped: () -> Void {
        return { [weak self] () in
            guard let `self` = self else { return }
            self.interactor.contentButtonTapped()
            self.didChange?()
        }
    }

    var defaultOptions:() -> [NavigationOption] {
        return { [weak self] in
            return self?.interactor.defaultOptions ?? []
        }
    }

    var detailOptions:() -> [NavigationOption] {
        return { [weak self] in
            guard let `self` = self else { return [] }
            return self.interactor.contentButtonSelected ? self.interactor.selectedOptions : self.interactor.unselectedOptions
        }
    }

    var informationOptions:() -> [NavigationOption] {
        return { [weak self] in
            return self?.interactor.informationOptions ?? []
        }
    }

    var dateExampleOptions:() -> [DateEntryItem] {
        return { [weak self] in
            return self?.interactor.dateExampleOptions ?? []
        }
    }

    var groupOptions:() -> [NavigationOption] {
        return { [weak self] in
            guard let `self` = self else { return [] }
            return self.interactor.groupOptions
        }
    }

    var buttonOptions:() -> [NavigationOption] {
        return { [weak self] in
            guard let `self` = self else { return [] }
            return self.interactor.contentButtonSelected ? self.interactor.buttonOptions + self.interactor.selectedOptions : self.interactor.buttonOptions
        }
    }

    var buttonIsSelected: () -> Bool {
        return { [weak self] in
            guard let `self` = self else { return false }
            return self.interactor.contentButtonSelected
        }
    }
}
