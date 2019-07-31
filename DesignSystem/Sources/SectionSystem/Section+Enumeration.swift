//
//  Section+Enumeration.swift
//  DesignSystem
//
//  Created by anthony on 31/07/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation

public protocol EnumeratableSection: Section {
    associatedtype DataType
}

//TODO: haven't considered nested sections yet

extension EnumeratableSection where Self: BedrockSection {

    public func enumerate(_ data: @escaping () -> [DataType]) -> BedrockSection {
        objc_setAssociatedObject(self, &AssociatedKeys.dataClosure, data, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return self
    }

    public var data: [DataType] {
        return objc_getAssociatedObject(self, &AssociatedKeys.dataStatic) as? [DataType] ?? []
    }
}

extension BedrockSection where Self: EnumeratableSection {

    public func pullData() {
        guard let closure = objc_getAssociatedObject(self, &AssociatedKeys.dataClosure) as? () -> [DataType] else {
            Assert("Could not create closure to pull into static data")
            return
        }
        objc_setAssociatedObject(self, &AssociatedKeys.dataStatic, closure(), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    public var itemCount: Int {
        return data.count
    }
}

private struct AssociatedKeys {
    static var dataClosure = "ssEnumeratableSectionDataClosure"
    static var dataStatic = "ssEnumeratableSectionStaticData"
}
