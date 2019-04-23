//
//  MyPageProfileSection.swift
//  Home
//
//  Created by anthony on 22/02/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation


extension SectionBuilder {
    public func profileHeader() -> Section {
        return MyPageProfileSection()
    }
}

internal class MyPageProfileSection {
    fileprivate init() { }
}

extension MyPageProfileSection: ViewControllerSection {

    public func createViewController() -> UIViewController {
        return MyPageProfileViewController()
    }

    public func size(in superview: UIView, at index: Int) -> CGSize? {
        return CGSize(width: superview.bounds.size.width, height: MyPageProfileViewController.height)
    }

    func configure(_ viewController: UIViewController, at index: Int, in controller: SectionController) {
        (viewController as? MyPageProfileViewController)?.reload()
    }
}
