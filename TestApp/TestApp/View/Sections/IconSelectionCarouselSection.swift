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

struct FractalIcon: IconOptions {
    var imageKey: UIImage.Key
    var isSelected: Bool
}

class IconSelectionCarouselSection {
    var offset: CGFloat = 0.0
    let icons = [FractalIcon(imageKey: .icon0, isSelected: true),
                 FractalIcon(imageKey: .icon1, isSelected: false),
                 FractalIcon(imageKey: .icon8, isSelected: false),
                 FractalIcon(imageKey: .icon7, isSelected: false),
                 FractalIcon(imageKey: .icon2, isSelected: false),
                 FractalIcon(imageKey: .icon3, isSelected: false),
                 FractalIcon(imageKey: .icon6, isSelected: false),
                 FractalIcon(imageKey: .icon5, isSelected: false),
                 FractalIcon(imageKey: .icon4, isSelected: false)]
}

extension IconSelectionCarouselSection: ViewControllerSection, SectionBuilder {

    public func createViewController() -> UIViewController {
        let vc = CarouselViewController()
        vc.dataSource.sections = [iconSelection(self.icons)]
        vc.reload()
        return vc
    }

    public func size(in view: UIView, at index: Int) -> SectionCellSize {
        return SectionCellSize(width: view.bounds.size.width, height: 120.0)
    }

    func configure(_ viewController: UIViewController, at index: Int) {
        //TODO: set offset
    }
}
