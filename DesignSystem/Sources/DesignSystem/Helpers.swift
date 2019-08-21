//
//  Helpers.swift
//  DesignSystem
//
//  Created by anthony on 15/02/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import UIKit

public let isIPad = UIDevice.current.userInterfaceIdiom == .pad

func Assert(_ message: String = "") {
    #if DEBUG
    print("Assert:", message)
    fatalError()
    #endif
}

extension UIView {

    public func findShallowestInHierarchy<V, B>(_ type1: V.Type, _ type2: B.Type) -> (V?, B?) {
        var v: UIView? = superview
        while !(v is V) && !(v is B) && v != nil { v = v?.superview }
        return (v as? V, v as? B)
    }

    public func findInHierarchy<V>(_ type: V.Type) -> V? {
        var v: UIView? = superview
        while !(v is V) && v != nil { v = v?.superview }
        return v as? V
    }
}
