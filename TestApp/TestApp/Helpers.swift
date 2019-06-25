//
//  Helpers.swift
//  DesignSystemApp
//
//  Created by anthony on 15/02/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation

func Assert(_ message: String = "") {

    #if DEBUG
    print("Assert:", message)
    fatalError()
    #endif
}
