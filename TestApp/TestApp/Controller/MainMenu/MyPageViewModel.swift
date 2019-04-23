//
//  MyPageViewModel.swift
//  DesignSystemApp
//
//  Created by anthony on 10/04/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import UIKit

struct MyPageMenuOption {

    let title: String
    let intent: String?

    init(title: String, intent: String?) {
        self.title = title
        self.intent = intent
    }
}

extension MyPageViewController {

    class ViewModel {

        static let headerViewHeight: CGFloat = 60.0

        var versionString: () -> String {
            let closure: () -> String = { return "1.0.0 (100)" }
            return closure
        }

        var menuOptions:() -> [MyPageMenuOption] {
            return { [weak self] in
                return self?.staticMenuOptions ?? []
            }
        }

        private var staticMenuOptions: [MyPageMenuOption] = {

            let like = "Likes"
            let exhibit = "Exhibit"
            let buy = "Buy"
            let draft = "Draft"
            let coupon = "Coupon"

            let options = [MyPageMenuOption(title: like, intent: "like"),
                           MyPageMenuOption(title: exhibit, intent: "like"),
                           MyPageMenuOption(title: buy, intent: "like"),
                           MyPageMenuOption(title: draft, intent: "like"),
                           MyPageMenuOption(title: coupon, intent: "like")]
            return options
        }()
    }
}

