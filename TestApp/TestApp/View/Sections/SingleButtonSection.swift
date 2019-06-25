//
//  ButtonComponentViewModel.swift
//  SectionSystem
//
//  Created by Anthony Smith on 09/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import DesignSystem

extension SectionBuilder {
    public func singleButton(_ title: String, style: Button.Style = .primary, hiddenClosure: (() -> Bool)? = nil, tappedClosure: @escaping () -> Void, selectedClosure: (() -> Bool)? = nil) -> SingleButtonSection {
        return SingleButtonSection(title, style: style, hiddenClosure: hiddenClosure, tappedClosure: tappedClosure, selectedClosure: selectedClosure)
    }
}

public class SingleButtonSection {

    fileprivate let title: String
    fileprivate let style: Button.Style
    fileprivate let hiddenClosure: (() -> Bool)?
    fileprivate let tappedClosure: () -> Void
    fileprivate let selectedClosure: (() -> Bool)?

    init(_ title: String, style: Button.Style = .primary, hiddenClosure: (() -> Bool)? = nil, tappedClosure: @escaping () -> Void, selectedClosure: (() -> Bool)? = nil) {
        self.title = title
        self.style = style
        self.hiddenClosure = hiddenClosure
        self.tappedClosure = tappedClosure
        self.selectedClosure = selectedClosure
    }
}

extension SingleButtonSection: ViewSection {
    public var reuseIdentifier: String {
        return "SingleButtonSection_\(style.rawValue)"
    }

    public func createView() -> UIView {
        return SingleButtonView(style: style)
    }

    public var itemCount: Int {
        guard let hiddenClosure = self.hiddenClosure else { return 1 }
        return hiddenClosure() ? 0 : 1
    }
    
    public func size(in view: UIView, at index: Int) -> SectionCellSize {
        return SectionCellSize(width: view.bounds.size.width, height: nil)
    }

    public func configure(_ view: UIView, at index: Int) {
        (view as? SingleButtonView)?.set(buttonTitle: self.title, selected: self.selectedClosure?() ?? false, closure: self.tappedClosure)
    }
}
