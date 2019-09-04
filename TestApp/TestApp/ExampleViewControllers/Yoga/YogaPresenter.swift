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
    
    let popularEvents = [YogaModelObject(title: "Bikram Beginner", imageName: "bikram", startDate: Date()),
                         YogaModelObject(title: "Hot Yoga", imageName: "hotyoga", startDate: Date()),
                         YogaModelObject(title: "Advanced", imageName: "adv_yoga", startDate: Date()),
                         YogaModelObject(title: "Restorative", imageName: "restore", startDate: Date()),
                         YogaModelObject(title: "Kundalini", imageName: "kundalini", startDate: Date()),
                         YogaModelObject(title: "Cat Yoga", imageName: "cat_yoga", startDate: Date())]
    
    let newEvents = [YogaModelObject(title: "Vinyasa", imageName: "high", startDate: Date()),
                     YogaModelObject(title: "Ok Yoga", imageName: "ok", startDate: Date()),
                     YogaModelObject(title: "Yoga with Friends", imageName: "Jennifer-Aniston-Yoga", startDate: Date()),
                     YogaModelObject(title: "Vegan Yoga", imageName: "vegan", startDate: Date()),
                     YogaModelObject(title: "Advanced Cat Yoga", imageName: "advanced_cat", startDate: Date()),
                     YogaModelObject(title: "Licence to Yoga", imageName: "bond", startDate: Date())]
    
    func eventSelected(event: YogaSectionOption) {
        NavigationRouter.shared.yogaEventTapped(event)
    }
}

struct YogaModelObject {
    let title: String
    let imageName: String
    let startDate: Date
}

extension YogaModelObject: YogaSectionOption {
    var _title: String { return title }
    var _image: UIImage? { return UIImage(named: imageName) }
}
