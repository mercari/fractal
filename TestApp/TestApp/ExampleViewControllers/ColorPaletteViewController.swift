//
//  ColorPaletteViewController.swift
//  DesignSystemApp
//
//  Created by anthony on 11/01/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import DesignSystem

class ColorPaletteViewController: UIViewController, SectionBuilder {

    private var sectionController: SectionController!

    override func viewDidLoad() {
        title = "ColorPaletteVC"
        super.viewDidLoad()
        view.backgroundColor = .background
        DependencyRegistry.shared.prepare(viewController: self)
        sectionController.dataSource.sections = paletteSections
        sectionController.reload()
    }

    func inject(sectionController: SectionViewController) {
        self.contain(sectionController)
        self.sectionController = sectionController
    }

    // MARK: - Properties

    private var paletteSections: [Section] {

        var sections: [Section] = []
        guard var rawPalette = (BrandingManager.brand as? BrandTest)?.rawPalette else { return [] }
        let sectionNames = ["blue", "red", "green", "orange", "yellow", "pink", "mono"]

        for name in sectionNames {
            let options = rawPalette.filter { $0.name.contains(name) }
            guard options.count > 0 else { continue }
            rawPalette = rawPalette.filter { !$0.name.contains(name) }

            let optionSections: [Section] = [headline(name.capitalized),
                                             spacing(),
                                             paletteOptions(options)]
            sections.append(contentsOf: optionSections)
        }

        if rawPalette.count > 0 {
            let optionSections: [Section] = [headline("Other"),
                                             spacing(),
                                             paletteOptions(rawPalette)]
            sections.append(contentsOf: optionSections)
        }

        return sections
    }
}
