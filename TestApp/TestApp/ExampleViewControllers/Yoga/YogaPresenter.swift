//
//  YogaPresenter.swift
//  TestApp
//
//  Created by anthony on 02/09/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import UIKit

class MockYogaPresenter {
    
    let yogaTypes = ["Vinyasa", "Ashtanga", "Iyengar", "Bikram", "Jivamukti", "Power", "Cat", "Yin", "Vegan"]
    
    let popularEvents = [
        YogaEvent(title: "Kundalini", imageName: "kundalini",
                  times: "Mondays 10:00", price: 10, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
        YogaEvent(title: "Hot Yoga", imageName: "hotyoga",
                  times: "Every weekday 10:00", price: 7, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
        YogaEvent(title: "Advanced", imageName: "adv_yoga",
                  times: "Every weekday 5am\nWeekends 7am", price: 12, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
        YogaEvent(title: "Restorative", imageName: "restore",
                  times: "Monday 9am\nWednesday 9am\nFriday 9am", price: 14, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
        YogaEvent(title: "Bikram Beginner", imageName: "bikram",
                  times: "Monday 9am", price: 12, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
        YogaEvent(title: "Cat Yoga", imageName: "cat_yoga",
                  times: "Saturday 3pm", price: 9, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.")]
    
    let newEvents = [
        YogaEvent(title: "Vinyasa", imageName: "high",
                  times: "Mon, Tues, Wed, Thurs, Fri 8:00", price: 5, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
        YogaEvent(title: "Ok Yoga", imageName: "ok",
                  times: "Saturday 10:00\nSunday 10:00", price: 10, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
        YogaEvent(title: "Yoga with Friends", imageName: "Jennifer-Aniston-Yoga",
                  times: "Weekdays 9am", price: 8, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
        YogaEvent(title: "Vegan Yoga", imageName: "vegan",
                  times: "Weekdays 6:00", price: 14, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam."),
        YogaEvent(title: "Advanced Cat Yoga", imageName: "advanced_cat",
                  times: "Weekends 19:00", price: 9, description: "Lorem ipsum dolor sit amet."),
        YogaEvent(title: "Licence to Yoga", imageName: "bond",
                  times: "Fridays 7am", price: 20, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")]
    
    func eventSelected(event: YogaSectionOption) {
        NavigationRouter.shared.yogaEventTapped(event)
    }
}

struct YogaEvent {
    let title: String
    let imageName: String
    let times: String
    let price: Int
    let description: String
}

extension YogaEvent: YogaSectionOption {
    var image: UIImage? { return UIImage(named: imageName) }
}
