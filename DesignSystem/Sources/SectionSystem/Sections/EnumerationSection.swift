//
//  EnumerationSection.swift
//  DesignSystem
//
//  Created by Anthony Smith on 25/07/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation

extension SectionBuilder {
    public func forEach<V>(_ values: () -> [V], sectionClosure: (V) -> Section) -> EnumerationSection {
        return EnumerationSection()
    }

    public func forEach<V>(_ values: () -> [V], sectionClosure: (V) -> [Section]) -> EnumerationSection {
        return EnumerationSection()
    }
}

public class EnumerationSection {
    
    // enumeration on data to override the item count (create enumerator on BedrockSection?)
}

//
//extension EnumerationSection: NestedSection {
//    public var allSections: [Section] {
//        <#code#>
//    }
//
//    public var givenSections: [Section] {
//        <#code#>
//    }
//
//    public func section(at index: Int) -> Section {
//        <#code#>
//    }
//
//
//
//}
