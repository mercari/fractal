//
//  NavigationGroupSection.swift
//  SectionSystem
//
//  Created by anthony on 18/02/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation


extension SectionBuilder {
    public func navigationGroup(_ title: String,
                                options: @escaping () -> [NavigationOption],
                                style: NavigationOptionView.Style = .default,
                                selectionClosure: @escaping (Int, NavigationOption) -> Void) -> NavigationGroupSection {
        let section = NavigationGroupSection()
        section.set(title, options: options, style: style, selectionClosure: selectionClosure)
        return section
    }
}

public class NavigationGroupSection: SectionBuilder {
    fileprivate var sections: [Section] = []
    fileprivate var indexOfGroup: Int = -1

    fileprivate func set(_ title: String, options: @escaping () -> [NavigationOption], style: NavigationOptionView.Style = .default, selectionClosure: @escaping (Int, NavigationOption) -> Void) {
        sections = [headline(title), group([navigationOptions(options, style: style, selectionClosure: selectionClosure)])]
        indexOfGroup = sections.count - 1
    }

    fileprivate var headline: HeadlineSection {
        return sections[0] as! HeadlineSection
    }

    fileprivate var group: GroupSection {
        return sections[indexOfGroup] as! GroupSection
    }
}

extension NavigationGroupSection: NestedSection {
    public var allSections: [Section] {
        return sections
    }

    public var givenSections: [Section] {
        return sections
    }

    public func section(at index: Int) -> Section {
        guard index >= indexOfGroup else { return sections[index] }
        return group.section(at: index - indexOfGroup)
    }

    public var itemCount: Int {
        return group.itemCount + indexOfGroup
    }

    public func givenSectionIndex(from index: Int) -> Int {
        guard index >= indexOfGroup else { return index }
        return group.givenSectionIndex(from: index - indexOfGroup)
    }
}
