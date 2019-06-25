//
//  ButtonExamplePresenter.swift
//  DesignSystemApp
//
//  Created by Anthony Smith on 12/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit

class ButtonExamplePresenter  {

    var toggleButtonIsSelected = false
    var didChange: (() -> Void)?

    var toggleButtonSelected: () -> Bool {
        return { [weak self] in
            guard let `self` = self else { return false }
            return self.toggleButtonIsSelected
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

    var attentionButtonTapped: () -> Void {
        return { () in
            print("TODO: Forward action for attention button")
        }
    }

    var toggleButtonTapped: () -> Void {
        return { [weak self] () in
            guard let `self` = self else { return }
            self.toggleButtonIsSelected = !self.toggleButtonIsSelected
            self.didChange?()
        }
    }

    var optionsButtonTapped: (Int) -> Void {
        return { (index) in
            print("Did select option:", index)
        }
    }

    var carouselButtonTapped: () -> Void {
        return { () in
            print("TODO: Carousel button")
        }
    }
}
