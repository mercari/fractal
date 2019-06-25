//
//  ButtonGroup.swift
//  SectionSystem
//
//  Created by anthony on 18/02/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

extension SectionBuilder {
    public func buttonOptions(_ titles: [String], style: Button.Style = .primary, selectionClosure: @escaping (Int) -> Void) -> ButtonGroupSection {
        let section = ButtonGroupSection(style: style)
        section.set(titles, selection: selectionClosure)
        return section
    }
}

public class ButtonGroupSection: SectionBuilder {

    fileprivate var sections: [Section] = []
    fileprivate let style: Button.Style

    init(style: Button.Style) {
        self.style = style
    }

    fileprivate func set(_ titles: [String], selection: @escaping (Int) -> Void) {
        let types: [Section] = titles.enumerated().map { (index, element) in
            return singleButton(element, style: style, tappedClosure: { selection(index) })
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
