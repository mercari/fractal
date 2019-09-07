//
//  YogaDetailPresenter.swift
//  TestApp
//
//  Created by anthony on 02/09/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import UIKit
import DesignSystem

class YogaDetailPresenter {

    let event: YogaEvent
        
    init(_ event: YogaEvent) {
        self.event = event
    }
    
    let comments = [
        Comment(user: User(firstName: "Jon", lastName: "Bott", imageName: "jon"),
                date: Date(timeIntervalSince1970: 1567865610),
                text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
        Comment(user: User(firstName: "Tom", lastName: "Oliver", imageName: "tom"),
                date: Date(timeIntervalSince1970: 1567800000),
                text: "Lorem ipsum dolor sit amet."),
        Comment(user: User(firstName: "Anthony", lastName: "Smith", imageName: "anthony"),
                date: Date(timeIntervalSince1970: 1567000000),
                text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
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
        return BrandingManager.dateManager.string(from: date, style: .fuzzy, placeholder: "Unknown date")
    }
    
    var comment: String {
        return text
    }
}

