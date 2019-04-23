//
//  NavigationExampleInteractor.swift
//  DesignSystemApp
//
//  Created by anthony on 22/01/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation

class NavigationExampleInteractor {

    private(set) var contentButtonSelected = false

    func contentButtonTapped() {
        contentButtonSelected = !contentButtonSelected
    }

    var defaultOptions: [NavigationExampleEntity] = {
        let options = [NavigationExampleEntity.init(title: "First", intent: "navigationExample"),
                       NavigationExampleEntity.init(title: "First", intent: "navigationExample"),
                       NavigationExampleEntity.init(title: "First", intent: "navigationExample")]
        return options
    }()

    var detailOptions: [NavigationExampleEntity] = {
        let options = [NavigationExampleEntity.init(title: "Second", detail: "Detail", intent: "navigationExample"),
                       NavigationExampleEntity.init(title: "Second",
                                                    detail: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
                                                    intent: "navigationExample"),
                       NavigationExampleEntity.init(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
                                                    detail: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
                                                    intent: "navigationExample")]
        return options
    }()

    var informationOptions: [NavigationExampleEntity] = {
        let options = [NavigationExampleEntity.init(title: "Third",
                                                    detail: "Information",
                                                    intent: "navigationExample"),
                       NavigationExampleEntity.init(title: "Third Third",
                                                    detail: "Lorem ipsum dolor sit amet, consectetur adipiscing elit,",
                                                    intent: "navigationExample"),
                       NavigationExampleEntity.init(title: "Third Third Third Third Third Third",
                                                    detail: "Lorem ipsum dolor sit amet, consectetur adipiscing elit,",
                                                    intent: "navigationExample")]
        return options
    }()

    var unselectedOptions: [NavigationExampleEntity] = {
        let options = [NavigationExampleEntity.init(title: "Unselected", detail: "Detail", intent: "navigationExample")]
        return options
    }()

    var selectedOptions: [NavigationExampleEntity] = {
        let options = [NavigationExampleEntity(title: "Selected", detail: "Detail", intent: "navigationExample"),
                       NavigationExampleEntity(title: "Selected2", detail: "Detail", intent: "navigationExample"),
                       NavigationExampleEntity(title: "Selected3", detail: "Detail", intent: "navigationExample")]
        return options
    }()

    var groupOptions: [NavigationExampleEntity] = {
        let options = [NavigationExampleEntity.init(title: "Group", intent: "navigationExample"),
                       NavigationExampleEntity.init(title: "Group2", intent: "navigationExample"),
                       NavigationExampleEntity.init(title: "Group3", intent: "navigationExample"),
                       NavigationExampleEntity.init(title: "Group4", intent: "navigationExample"),
                       NavigationExampleEntity.init(title: "Group5", intent: "navigationExample"),
                       NavigationExampleEntity.init(title: "Group6", intent: "navigationExample")]

        return options
    }()

    var buttonOptions: [NavigationExampleEntity] = {
        let options = [NavigationExampleEntity.init(title: "Button", intent: "navigationExample")]
        return options
    }()

    var dateExampleOptions: [NavigationExampleDateEntity] = {
        let firstOption = NavigationExampleDateEntity(date: Date(), text: "First one", disclosureText: "Text")
        let secondOption = NavigationExampleDateEntity(date: Date(), text: "Second option with a super long title so we can test more than one line of text wraps correctly", disclosureText: "Text")
        let options = [firstOption, secondOption]
        return options
    }()
}
