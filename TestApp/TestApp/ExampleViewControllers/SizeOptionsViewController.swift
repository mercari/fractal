//
//  SizeOptionsViewController.swift
//  DesignSystemApp
//
//  Created by anthony on 17/01/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import DesignSystem

class SizeOptionsViewController: UIViewController, SectionBuilder {

    private var sectionController: SectionViewController!
    private var iconToggled: Bool = false

    override func viewDidLoad() {
        title = "SizeOptionsVC"
        super.viewDidLoad()
        view.backgroundColor = .background()
        DependencyRegistry.shared.prepare(viewController: self)

        sectionController.dataSource.sections = [headline("Spacing"),
                                                 spacing(),
                                                 sizeOptions(spacingOptions),
                                                 spacing(),
                                                 headline("Icon / Thumbnail"),
                                                 spacing(),
                                                 sizeOptions(iconSizeOptions),
                                                 spacing()]
        sectionController.reload()
    }

    func inject(sectionController: SectionViewController) {
        self.contain(sectionController)
        self.sectionController = sectionController
    }

    private var spacingOptions: [SizeOption] {

        let options = BrandingManager.Spacing.allCases.map { (size) -> SizeOption in
            let value = BrandingManager.brand.value(for: size)
            let valueString = String(format: "%.0f", value)
            let name = "\(size.rawValue) \(valueString)"
            return Size(value: (name, CGSize(width: 0.0, height: value)))
        }

        return options
    }

    private var iconSizeOptions: [SizeOption] {

        let options = BrandingManager.IconSize.allCases.map { (size) -> SizeOption in
            let value = BrandingManager.brand.value(for: size)
            let valueString = String(format: "%.0fx%.0f", value.width, value.height)
            let name = "\(size.rawValue) \(valueString)"
            return Size(value: (name, value))
        }

        return options
    }
}

fileprivate struct Size: SizeOption {
    fileprivate let value: (String, CGSize)
    var name: String { return value.0 }
    var size: CGSize { return value.1 }
}
