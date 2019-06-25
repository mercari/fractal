//
//  ImageView+Extensions.swift
//  TestApp
//
//  Created by anthony on 29/05/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

extension ImageView {

    public convenience init(design: UIImage.Design, renderingMode: UIImage.RenderingMode = .alwaysOriginal) {
        self.init(image: ImageView.localImage(named: design.rawValue)?.withRenderingMode(renderingMode))
    }

    fileprivate static func localImage(named name: String) -> UIImage? {
        guard let image = UIImage(named: name, in: Bundle(for: self), compatibleWith: nil) else {
            assertionFailure("failed to find image \(name)")
            return nil
        }
        return image
    }
}

extension UIImage {

    public enum Design: String { //TODO: pivot on brand
        case detailDisclosure = "icn_disclosure_indicator",
        check = "check",
        smallArrow = "small_arrow"
    }

    public static func with(design: UIImage.Design, renderingMode: UIImage.RenderingMode = .alwaysOriginal) -> UIImage? {
        return ImageView.localImage(named: design.rawValue)?.withRenderingMode(renderingMode)
    }
}
