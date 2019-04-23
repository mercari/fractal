//
//  ButtonGroup.swift
//  SectionSystem
//
//  Created by anthony on 18/02/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation


extension SectionBuilder {
    public func buttonOptions(_ titles: [String], alternativesHeader: String? = nil, selectionClosure: @escaping (Int) -> Void) -> ButtonGroupSection {
        let section = ButtonGroupSection()
        section.set(titles, alternativesHeader: alternativesHeader, selection: selectionClosure)
        return section
    }
}

public class ButtonGroupSection: SectionBuilder {

    fileprivate var sections: [Section] = []

    fileprivate func set(_ titles: [String], alternativesHeader: String? = nil, selection: @escaping (Int) -> Void) {
        var types: [Section] = titles.enumerated().map { (index, element) in
            return singleButton(element, tappedClosure: { selection(index) })
        }

        if let altHeader = alternativesHeader, titles.count > 1 {
            let altHeaderSections: [Section] = [spacing(), textDivider(altHeader), spacing()]
            types.insert(contentsOf: altHeaderSections, at: 1)
        }

        sections = types
    }
}

extension ButtonGroupSection: NestedSection {
    public var allSections: [Section] {
        return sections
    }

    public var givenSections: [Section] {
        return sections
    }

    public func section(at index: Int) -> Section {
        return sections[index]
    }

    public var itemCount: Int {
        return sections.count
    }
}
