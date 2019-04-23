//
//  DateEntrySection.swift
//  Home
//
//  Created by plimc on 2019/03/14.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation


extension SectionBuilder {
    /// Builds a Section of DateEntryItems.
    ///
    /// - Parameter itemsProvider: A closure that returns the items to display. It should return quickly and not do any heavy computations because it is executed on every reload.
    /// - Parameter style: display style, such as whether to show a disclosure label in each cell.
    /// - Parameter selectionClosure: Given the item index, performs the action of selecting that item.
    public func dateEntries(_ itemsProvider: @escaping () -> [DateEntryItem], style: DateEntryView.Style = .default, selectionClosure: @escaping (Int) -> Void) -> ReloadableSection<DateEntryItem, DateEntryView> {
        return DateEntrySection(itemsProvider: itemsProvider, style: style, selectionClosure: selectionClosure)
    }
}

public protocol DateEntryItem {
    var text: String { get }
    var disclosureText: String? { get }
    var date: Date { get }
}

public extension DateEntryItem {
    var disclosureText: String? { return nil }
}

private class DateEntrySection: ReloadableSection<DateEntryItem, DateEntryView> {

    private var selectionClosure: (Int) -> Void
    private let style: DateEntryView.Style

    init(itemsProvider: @escaping () -> [DateEntryItem], style: DateEntryView.Style = .default, selectionClosure: @escaping (Int) -> Void) {
        self.selectionClosure = selectionClosure
        self.style = style
        super.init(with: itemsProvider)
    }

    override func newView() -> DateEntryView {
        return DateEntryView(style: style)
    }

    override func configure(_ view: DateEntryView, with item: DateEntryItem) {
        view.set(displayTime: item.date, text: item.text, disclosureText: item.disclosureText)
    }

    override var reuseIdentifier: String {
        return "DateEntryView_\(style.rawValue)"
    }

    override func didSelect(_ view: UIView, at index: Int) {
        selectionClosure(index)
    }
}
