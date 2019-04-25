//
//  ImageView.swift
//  DesignSystem
//
//  Created by anthony on 19/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit

public class ImageView: UIImageView {
    // Currently does nothing but wrapped to inherit future features
}

extension ImageView {

    public convenience init(design: UIImage.Design, renderingMode: UIImage.RenderingMode = .alwaysOriginal) {
        self.init(image: ImageView.localImage(named: design.rawValue)?.withRenderingMode(renderingMode))
    }

    fileprivate static func localImage(named name: String) -> UIImage? {
        guard let image = UIImage(named: name, in: Bundle(for: self), compatibleWith: nil) else {
            Assert("failed to find image \(name)")
            return nil
        }
        return image
    }
}

extension UIImage {

    public enum Design: String { //TODO: pivot on brand
        case detailDisclosure = "icn_disclosure_indicator",
        clock4pm = "icn_clock_4pm",
        profilePlaceholder = "prof_noimage",
        profileHeader = "prof_bg",
        check = "check",
        smallArrow = "small_arrow",
        starOff = "star_off",
        starOn = "star_on",
        starHalf = "star_half",
        official = "official"
    }

    public static func with(design: UIImage.Design, renderingMode: UIImage.RenderingMode = .alwaysOriginal) -> UIImage? {
        return ImageView.localImage(named: design.rawValue)?.withRenderingMode(renderingMode)
    }
}
