//
//  TickBoxOptionsSection.swift
//  SectionSystem
//
//  Created by anthony on 10/04/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation


public protocol CheckboxOption {
    // _ prefix prevents clashes with model objects
    var _id: String { get }
    var _title: String { get }
    var _detail: String? { get }
}

extension SectionBuilder {
    public func checkboxOptions(_ dataClosure: @escaping () -> (Int, [CheckboxOption]), style: CheckboxOptionView.Style = .default, selectionClosure: @escaping (Int, CheckboxOption) -> Void) -> CheckboxOptionSection {
        return CheckboxOptionSection(dataClosure, style: style, selectionClosure: selectionClosure)
    }
}

public class CheckboxOptionSection {

    // Marked as internal for testing
    internal private(set) var staticOptions: [CheckboxOption]
    internal private(set) var selectedIndex: Int = -1

    fileprivate let dataClosure: () -> (Int, [CheckboxOption])
    fileprivate let style: CheckboxOptionView.Style
    fileprivate let selectionClosure: (Int, CheckboxOption) -> Void
    fileprivate var currentVisibleViews: [CheckboxOptionView] = []

    public init(_ dataClosure: @escaping () -> (Int, [CheckboxOption]),
                style: CheckboxOptionView.Style = .default,
                selectionClosure: @escaping (Int, CheckboxOption) -> Void) {

        self.style = style
        self.dataClosure = dataClosure
        self.selectionClosure = selectionClosure
        let data = dataClosure()
        selectedIndex = data.0
        staticOptions = data.1
    }
}

extension CheckboxOptionSection: ViewSection, VisibleViewSection {

    public var reuseIdentifier: String {
        return "Tickbox_\(style.rawValue)"
    }

    public func willReload() {
        let data = dataClosure()
        selectedIndex = data.0
        staticOptions = data.1
    }

    public func createView() -> UIView {
        return CheckboxOptionView(style: style)
    }

    public var itemCount: Int {
        return staticOptions.count
    }

    public func configure(_ view: UIView, at index: Int) {
        guard let checkboxView = view as? CheckboxOptionView else { return }
        let option = staticOptions[index]
        currentVisibleViews.append(checkboxView)
        checkboxView.set(title: option._title, detail: option._detail)
        checkboxView.set(isSelected: index == selectedIndex)
    }

    public func didSelect(_ view: UIView, at index: Int) {
        guard let checkboxView = view as? CheckboxOptionView else { return }
        selectedIndex = index
        for view in currentVisibleViews { view.set(isSelected: false) }
        checkboxView.set(isSelected: true)
        selectionClosure(index, staticOptions[index])
    }

    public var visibleView: UIView? {
        Assert("CheckboxOptionSection is an array of items, please use visibleViews: instead of visibleView:")
        return nil
    }

    public var visibleViews: [UIView]? {
        return currentVisibleViews
    }

    public func viewBeingRecycled(_ view: UIView) {
        guard let checkboxView = view as? CheckboxOptionView else { return }
        let removed = currentVisibleViews.filter { $0 != checkboxView }
        currentVisibleViews = removed
    }
}