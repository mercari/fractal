//
//  NSObject+Extensions.swift
//  DesignSystem
//
//  Created by anthony on 10/01/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation

extension NSObject {

    class func className() -> String {
        return String(describing: self)
    }

    func className() -> String {
        return type(of: self).className()
    }
}
