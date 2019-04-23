//
//  TextView.swift
//  Mercari
//
//  Created by Anthony Smith on 26/03/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit

final public class TextView: UITextView {

    static let placeholderColor: UIColor = .text(.placeholder)
    static let defaultTypography: BrandingManager.Typography = .medium

    var placeholder: String?
    var indexPath: IndexPath?
    var key: String?

    private var heldTextColor: UIColor?
    override public var textColor: UIColor? { didSet { if textColor != TextView.placeholderColor { heldTextColor = textColor } } }

    public init() {
        super.init(frame: .zero, textContainer: nil)
        setup()
    }

    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: .zero, textContainer: textContainer)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        font = TextView.defaultTypography.font
        textColor = .text()
        tintColor = .brand()
        backgroundColor = .clear
        contentInset = .zero
        keyboardAppearance = BrandingManager.brand.keyboardAppearance
    }

    override public func layoutSubviews() {

        super.layoutSubviews()
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
    }

    public func checkForPlaceholder() {

        guard !isFirstResponder else { return }
        if !(placeholder?.isEmpty ?? true) && text.isEmpty { text = placeholder }
        textColor = text == placeholder ? TextView.placeholderColor : heldTextColor
    }
}
