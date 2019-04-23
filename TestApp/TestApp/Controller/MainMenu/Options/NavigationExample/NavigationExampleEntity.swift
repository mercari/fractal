//
//  NavigationExampleEntity.swift
//  DesignSystemApp
//
//  Created by anthony on 06/02/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import DesignSystem

class NavigationExampleEntity: NavigationOption {

    let title: String
    let detail: String?
    let intent: String?

    init(title: String, detail: String? = nil, intent: String? = nil) {
        self.title = title
        self.detail = detail
        self.intent = intent
    }
}

class NavigationExampleDateEntity {
    var text: String
    var date: Date
    var disclosureText: String?

    init(date: Date, text: String, disclosureText: String?) {
        self.text = text
        self.date = date
        self.disclosureText = disclosureText
    }
}

extension NavigationExampleDateEntity: DateEntryItem { }
