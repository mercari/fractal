//
//  MainMenuPresenter.swift
//  DesignSystemApp
//
//  Created by anthony on 21/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import DesignSystem

private struct MenuOption: NavigationOption {

    private let _title: String
    private let _intent: String

    init(title: String, intent: String) {
        _title = title
        _intent = intent
    }

    var title: String { return _title }
    var detail: String? { return nil }
    var intent: String? { return _intent }
}

class MainMenuPresenter  {

    var selection: (Int, NavigationOption, UIViewController) -> Void {
        return { (_, option, viewController) in
            guard let rawIntent = option.intent else { return }
            NavigationRouter.shared.navigationOptionSelected(rawIntent)
        }
    }

    var systemOptions:() -> [NavigationOption] {
        return { [weak self] in
            guard let `self` = self else { return [] }
            return self.staticOptions
        }
    }

    var exampleOptions:() -> [NavigationOption] {
        return { [weak self] in
            guard let `self` = self else { return [] }
            return self.staticExamples
        }
    }

    var demoOptions:() -> [NavigationOption] {
        return { [weak self] in
            guard let `self` = self else { return [] }
            return self.staticDemo
        }
    }

    var staticOptions: [NavigationOption] = {
        let typo = MenuOption(title: "Typography", intent: NavigationRouter.Intent.typography.rawValue)
        let color = MenuOption(title: "Color Palette", intent: NavigationRouter.Intent.palette.rawValue)
        let size = MenuOption(title: "Size", intent: NavigationRouter.Intent.size.rawValue)
        return [typo, color, size]
    }()

    var staticExamples: [NavigationOption] = {
        let button = MenuOption(title: "Button", intent: NavigationRouter.Intent.buttonExample.rawValue)
        let selection = MenuOption(title: "Selection", intent: NavigationRouter.Intent.selectionExample.rawValue)
        //let filtering = MenuOption(title: "Filtering", intent: NavigationRouter.Intent.filteringExample.rawValue)
        //let card = MenuOption(title: "Card", intent: NavigationRouter.Intent.cardExample.rawValue)
        return [button, selection]
    }()

    var staticDemo: [NavigationOption] = {
        let yoga = MenuOption(title: "Yoga", intent: NavigationRouter.Intent.yoga.rawValue)
        let settings = MenuOption(title: "Settings", intent: NavigationRouter.Intent.settings.rawValue)
        return [yoga, settings]
    }()
}
