//
//  IconSelectionCarouselSection.swift
//  TestApp
//
//  Created by anthony on 11/07/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

extension SectionBuilder {
    func iconSelectionCarousel() -> IconSelectionCarouselSection {
        return IconSelectionCarouselSection()
    }
}

class IconSelectionCarouselSection {

    var offset: CGFloat = 0.0

    init() {

    }
}

extension IconSelectionCarouselSection: ViewControllerSection {

    public func createViewController() -> UIViewController {
        let vc = CarouselViewController()
        // TODO: add datasource
        return vc
    }

    public func size(in view: UIView, at index: Int) -> SectionCellSize {
        return SectionCellSize(width: view.bounds.size.width, height: 120.0)
    }

    func configure(_ viewController: UIViewController, at index: Int) {
        //TODO: set offset
    }
}
