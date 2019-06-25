//
//  AttributedString+BrandingManager.swift
//  DesignSample
//
//  Created by Anthony Smith on 28/08/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit

// I'm not sure how much I'd split this out if at all, the common theme is Typography extensions....

extension NSAttributedString {

    public convenience init(string: String, typography: BrandingManager.Typography, color: UIColor? = nil, underlineStyle: NSUnderlineStyle? = nil, alignment: NSTextAlignment = .left, paragraphStyle: NSMutableParagraphStyle? = nil) {

        var attr = [NSAttributedString.Key: Any]()
        attr[.font] = typography.font
        attr[.foregroundColor] = color ?? typography.defaultColor
        attr[.underlineStyle] = underlineStyle?.rawValue
        attr[.paragraphStyle] = paragraphStyle ?? NSAttributedString.paragraphStyle(for: typography, alignment: alignment)

        self.init(string: string, attributes: attr)
    }

    private static func paragraphStyle(for typography: BrandingManager.Typography, alignment: NSTextAlignment) -> NSMutableParagraphStyle {

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = typography.lineHeight - typography.font.lineHeight
        paragraphStyle.alignment = alignment

        return paragraphStyle
    }
}

extension Label {

    public func text(_ string: String?, typography: BrandingManager.Typography, color: UIColor? = nil, underlineStyle: NSUnderlineStyle? = nil) {

        let originalTextAlignment = textAlignment
        let attributedString = NSAttributedString(string: string ?? "",
                                                  typography: typography,
                                                  color: color ?? typography.defaultColor,
                                                  underlineStyle: underlineStyle)

        attributedText = attributedString
        textAlignment = originalTextAlignment
    }

    public func calculatedHeight(with width: CGFloat? = nil) -> CGFloat {
        guard let attributedString = attributedText else { return 0.0 }
        let rect = attributedString.boundingRect(with: CGSize(width: width ?? bounds.size.width, height: .infinity), options: .usesLineFragmentOrigin, context: nil)
        let numOflines = ceil(rect.size.height / actualLineHeight)
        return lineHeight * numOflines
    }
}

extension String {

    public func size(typography: BrandingManager.Typography, maxLines: Int = 0) -> CGSize {
        guard count > 0 else { return .zero }
        let attributedString = NSAttributedString(string: self, typography: typography)
        let rect = attributedString.boundingRect(with: CGSize(width: CGFloat.infinity, height: .infinity), options: .usesLineFragmentOrigin, context: nil)
        let lineHeight = typography.lineHeight
        let calculatedNumberOfLines = ceil(rect.size.height / lineHeight)
        let lines = maxLines > 0 && CGFloat(maxLines) < calculatedNumberOfLines ? CGFloat(maxLines) : calculatedNumberOfLines
        return CGSize(width: ceil(rect.size.width), height: ceil(lineHeight * lines))
    }

    public func height(typography: BrandingManager.Typography, width: CGFloat, maxLines: Int = 0) -> CGFloat {
        guard count > 0 else { return 0.0 }
        let attributedString = NSAttributedString(string: self, typography: typography)
        let rect = attributedString.boundingRect(with: CGSize(width: width, height: .infinity), options: .usesLineFragmentOrigin, context: nil)
        let lineHeight = typography.lineHeight
        let calculatedNumberOfLines = ceil(rect.size.height / lineHeight)
        let lines = maxLines > 0 && CGFloat(maxLines) < calculatedNumberOfLines ? CGFloat(maxLines) : calculatedNumberOfLines
        return ceil(lineHeight * lines)
    }
}
