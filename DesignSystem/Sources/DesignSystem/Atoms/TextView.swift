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

    public static let placeholderColor: UIColor = .text(.placeholder)
    public static let defaultTypography: BrandingManager.Typography = .medium

    private var usingPlaceholder: Bool = false
    private var heldTextColor: UIColor?
    public var placeholder: String? { didSet { addPlaceholderIfNeeded() }}
    public var indexPath: IndexPath?

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
        heldTextColor = textColor
        tintColor = .brand()
        backgroundColor = .clear
        contentInset = .zero
        keyboardAppearance = BrandingManager.brand.keyboardAppearance
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        textContainer.lineFragmentPadding = 0
    }

    private func addPlaceholderIfNeeded() {
        usingPlaceholder = !(placeholder?.isEmpty ?? true) && text.isEmpty
        if usingPlaceholder {
            text = placeholder
            textColor = TextView.placeholderColor
        }
    }

    @discardableResult public override func becomeFirstResponder() -> Bool {

        if usingPlaceholder {
            usingPlaceholder = false
            textColor = heldTextColor
            text = ""
        }

        return super.becomeFirstResponder()
    }

    @discardableResult public override func resignFirstResponder() -> Bool {
        addPlaceholderIfNeeded()
        return super.resignFirstResponder()
    }
}
