//
//  InformationViewModel.swift
//  SectionSystem
//
//  Created by anthony on 21/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import DesignSystem

extension SectionBuilder {
    public func information(_ title: String, detailClosure: @escaping () -> String) -> InformationSection {
        return InformationSection(title, detailClosure: detailClosure)
    }
}

public class InformationSection {
    fileprivate let title: String
    fileprivate let detailClosure: () -> String
    fileprivate var staticDetail: String

    init(_ title: String, detailClosure: @escaping () -> String) {
        self.title = title
        self.detailClosure = detailClosure
        self.staticDetail = detailClosure()
    }
}

extension InformationSection: ViewSection {

    public func willReload() {
        staticDetail = detailClosure()
    }

    public func createView() -> UIView {
        return InformationView()
    }

    public func size(in view: UIView, at index: Int) -> SectionCellSize {
        return SectionCellSize(width: view.bounds.size.width, height: nil)
    }
    
    public func configure(_ view: UIView, at index: Int) {
        (view as? InformationView)?.set(text: title, detail: staticDetail)
    }
}
