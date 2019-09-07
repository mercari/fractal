//
//  TickBoxOptionsSection.swift
//  SectionSystem
//
//  Created by anthony on 10/04/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

public protocol CheckboxOption {
    var id: String { get }
    var title: String { get }
    var detail: String? { get }
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

extension CheckboxOptionSection: ViewSection {

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
        checkboxView.set(title: option.title, detail: option.detail)
        checkboxView.set(isSelected: index == selectedIndex)
    }

    public func didSelect(_ view: UIView, at index: Int) {
        guard let checkboxView = view as? CheckboxOptionView else { return }
        selectedIndex = index
        for view in visibleViews { (view as? CheckboxOptionView)?.set(isSelected: false) }
        checkboxView.set(isSelected: true)
        selectionClosure(index, staticOptions[index])
    }
}
