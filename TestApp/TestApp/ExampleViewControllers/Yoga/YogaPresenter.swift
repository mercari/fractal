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
    
    let popularEvents = [YogaEvent(title: "Bikram Beginner", imageName: "bikram", startDate: Date()),
                         YogaEvent(title: "Hot Yoga", imageName: "hotyoga", startDate: Date()),
                         YogaEvent(title: "Advanced", imageName: "adv_yoga", startDate: Date()),
                         YogaEvent(title: "Restorative", imageName: "restore", startDate: Date()),
                         YogaEvent(title: "Kundalini", imageName: "kundalini", startDate: Date()),
                         YogaEvent(title: "Cat Yoga", imageName: "cat_yoga", startDate: Date())]
    
    let newEvents = [YogaEvent(title: "Vinyasa", imageName: "high", startDate: Date()),
                     YogaEvent(title: "Ok Yoga", imageName: "ok", startDate: Date()),
                     YogaEvent(title: "Yoga with Friends", imageName: "Jennifer-Aniston-Yoga", startDate: Date()),
                     YogaEvent(title: "Vegan Yoga", imageName: "vegan", startDate: Date()),
                     YogaEvent(title: "Advanced Cat Yoga", imageName: "advanced_cat", startDate: Date()),
                     YogaEvent(title: "Licence to Yoga", imageName: "bond", startDate: Date())]
    
    func eventSelected(event: YogaSectionOption) {
        NavigationRouter.shared.yogaEventTapped(event)
    }
}

struct YogaEvent {
    let title: String
    let imageName: String
    let startDate: Date
}

extension YogaEvent: YogaSectionOption {
    var _title: String { return title }
    var _image: UIImage? { return UIImage(named: imageName) }
}
