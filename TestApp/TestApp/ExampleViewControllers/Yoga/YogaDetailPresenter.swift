//
//  YogaDetailPresenter.swift
//  TestApp
//
//  Created by anthony on 02/09/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import UIKit

class YogaDetailPresenter {

    let event: YogaEvent
        
    init(_ event: YogaEvent) {
        self.event = event
    }
    
    let comments = [Comment(user: User(firstName: "Jon", lastName: "Bott", imageName: "ok"), date: Date(), text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
                    
                    Comment(user: User(firstName: "Tom", lastName: "Oliver", imageName: "restore"), date: Date(), text: "Lorem ipsum dolor sit amet.")
    
    ]
}

struct User {
    let firstName: String
    let lastName: String
    let imageName: String
}

struct Comment {
    let user: User
    let date: Date
    let text: String
}

extension Comment: CommentViewData {

    var name: String {
        return "\(user.firstName) \(user.lastName)"
    }
    
    var image: UIImage? {
        return UIImage(named: user.imageName)
    }
    
    var dateString: String {
        return "1st Jan 2001"
    }
    
    var comment: String {
        return text
    }
}

