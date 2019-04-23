//
//  HelpOptionSection.swift
//  SectionSystem
//
//  Created by anthony on 11/03/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation


extension SectionBuilder {
    public func help(_ title: String, selectionClosure: @escaping () -> Void) -> HelpOptionSection {
        return HelpOptionSection(title, selection: selectionClosure)
    }
}

public class HelpOptionSection {
    fileprivate let title: String
    fileprivate let selection: () -> Void

    public init(_ title: String, selection: @escaping () -> Void) {
        self.title = title
        self.selection = selection
    }
}

extension HelpOptionSection: ViewSection {

    public func createView() -> UIView {
        return HelpOptionView()
    }

    public func configure(_ view: UIView, at index: Int) {
        (view as? HelpOptionView)?.set(text: self.title)
    }

    public func didSelect(index: Int) {
        selection()
    }
}
