//
//  SwitchOptionViewModel.swift
//  SectionSystem
//
//  Created by anthony on 25/01/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

extension SectionBuilder {
    public func switchOption(_ title: String, detail: String? = nil, observedBool: Observable<Bool>) -> SwitchOptionSection {
        return SwitchOptionSection(title, detail: detail, observedBool: observedBool)
    }
}

public class SwitchOptionSection {
    fileprivate let title: String
    fileprivate let detail: String?
    fileprivate let style: SwitchOptionView.Style
    fileprivate weak var observedBool: Observable<Bool>?
    fileprivate var suppressUpdate: Bool = false

    init(_ title: String, detail: String? = nil, observedBool: Observable<Bool>) {
        self.title = title
        self.detail = detail
        self.style = detail == nil ? .default : .detail
        self.observedBool = observedBool
        self.observedBool?.addObserver(self) { [weak self] (value) in
            guard let `self` = self else { return }
            guard !self.suppressUpdate else { self.suppressUpdate = false; return }
            guard let visible = (self.visibleView as? SwitchOptionView) else { return }
            visible.set(value: value, animated: true)
        }
    }
}

extension SwitchOptionSection: ViewSection {

    public var reuseIdentifier: String {
        return "Switch_\(style.rawValue)"
    }

    public func createView() -> UIView {
        return SwitchOptionView(style: style)
    }

    public func size(in view: UIView, at index: Int) -> SectionCellSize {
        return SectionCellSize(width: view.bounds.size.width, height: nil)
    }
    
    public func configure(_ view: UIView, at index: Int) {
        guard let switchView = view as? SwitchOptionView else { return }
        switchView.set(title: title, detail: detail, didChangeClosure: { [weak self] (value) in
            guard let `self` = self else { return }
            self.suppressUpdate = true
            self.observedBool?.value = value
        })
        switchView.set(value: observedBool?.value ?? false, animated: false)
    }
}
