//
//  SectionController.swift
//  SectionSystem
//
//  Created by anthony on 21/12/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit


public protocol SectionController: class {
    func reload()
    func reloadSections(at indexes: [Int])
    var didPullDownToRefreshClosure: (() -> Void)? { get set }
    var dataSource: SectionControllerDataSource { get }
}

public extension SectionController {
    func reload() {
        reloadSections(at: [])
    }
}

public typealias SectionViewController = UIViewController & SectionController
