//
//  SwitchOptionViewModel.swift
//  SectionSystem
//
//  Created by anthony on 25/01/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation


extension SectionBuilder {
    public func switchOption(_ title: String, detail: String? = nil, observedBool: Observed<Bool>) -> SwitchOptionSection {
        return SwitchOptionSection(title, detail: detail, observedBool: observedBool)
    }
}

public class SwitchOptionSection {
    fileprivate let title: String
    fileprivate let detail: String?
    fileprivate let style: SwitchOptionView.Style
    fileprivate weak var observedBool: Observed<Bool>?
    fileprivate weak var currentView: SwitchOptionView?
    fileprivate var suppressUpdate: Bool = false

    init(_ title: String, detail: String? = nil, observedBool: Observed<Bool>) {
        self.title = title
        self.detail = detail
        self.style = detail == nil ? .default : .detail
        self.observedBool = observedBool
        self.observedBool?.addObserver(self) { [weak self] (value) in
            guard let `self` = self else { return }
            guard !self.suppressUpdate else { self.suppressUpdate = false; return }
            self.currentView?.set(value: value, animated: true)
        }
    }
}

extension SwitchOptionSection: ViewSection, VisibleViewSection {

    public var reuseIdentifier: String {
        return "Switch_\(style.rawValue)"
    }

    public func createView() -> UIView {
        return SwitchOptionView(style: style)
    }

    public func configure(_ view: UIView, at index: Int) {
        guard let switchView = view as? SwitchOptionView else { return }
        self.currentView = switchView
        switchView.set(title: title, detail: detail, didChangeClosure: { [weak self] (value) in
            guard let `self` = self else { return }
            self.suppressUpdate = true
            self.observedBool?.value = value
        })
        switchView.set(value: observedBool?.value ?? false, animated: false)
    }

    public var visibleView: UIView? {
        return currentView
    }

    public var visibleViews: [UIView]? {
        guard let view = currentView else { return [] }
        return [view]
    }

    public func viewBeingRecycled(_ view: UIView) {
        guard view == currentView else { return }
        currentView = nil
    }
}
