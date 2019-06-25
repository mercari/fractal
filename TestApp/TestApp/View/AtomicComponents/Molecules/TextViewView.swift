//
//  TextViewView.swift
//  DesignSystem
//
//  Created by anthony on 07/05/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import DesignSystem

public class TextViewView: UIView {

    public enum Option {
        case textAlignment(NSTextAlignment),
        isEditable(Bool),
        isSelectable(Bool),
        dataDetectorTypes(UIDataDetectorTypes),
        returnKeyType(UIReturnKeyType),
        keyboardType(UIKeyboardType),
        autocorrectionType(UITextAutocorrectionType),
        spellCheckingType(UITextSpellCheckingType),
        autocapitalizationType(UITextAutocapitalizationType)
    }

    public static let typography: BrandingManager.Typography = TextView.defaultTypography

    public init() {
        super.init(frame: .zero)
        backgroundColor = .background(.cell)
        addSubview(textView)
        textView.pin(to: self, [.leading(.keyline),
                                .top(.small),
                                .bottom(-.small),
                                .width(-.keyline*2, options: [.relation(.lessThanOrEqual)]),
                                .width(asConstant: 10.0, options: [.relation(.greaterThanOrEqual)]) //To preserve cursor when no text
            ])
        pin([.height(BrandingManager.brand.defaultCellHeight, options: [.relation(.greaterThanOrEqual)])])
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(text: String?) {
        textView.text = text
    }

    public func set(delegate: UITextViewDelegate, placeholder: String?, options: [Option]) {
        textView.delegate = delegate
        textView.placeholder = placeholder

        // Default option values
        textView.textAlignment = .left
        textView.isEditable = true
        textView.isSelectable = true
        textView.dataDetectorTypes = []
        textView.returnKeyType = .default
        textView.keyboardType = .default
        textView.autocorrectionType = .default
        textView.spellCheckingType = .default
        textView.autocapitalizationType = .sentences

        // If you add an option twice, the last value will be used
        for o in options {
            switch o {
            case .textAlignment(let value):
                textView.textAlignment = value
            case .isEditable(let value):
                textView.isEditable = value
            case .isSelectable(let value):
                textView.isSelectable = value
            case .dataDetectorTypes(let value):
                textView.dataDetectorTypes = value
            case .returnKeyType(let value):
                textView.returnKeyType = value
            case .keyboardType(let value):
                textView.keyboardType = value
            case .autocorrectionType(let value):
                textView.autocorrectionType = value
            case .spellCheckingType(let value):
                textView.spellCheckingType = value
            case .autocapitalizationType(let value):
                textView.autocapitalizationType = value
            }
        }
    }

    // MARK: - Overrides

    public override func becomeFirstResponder() -> Bool {
        return textView.becomeFirstResponder()
    }

    public override var isFirstResponder: Bool {
        return textView.isFirstResponder
    }

    // MARK: - Properties

    public lazy var textView: TextView = {
        let textView = TextView()
        textView.contentInset = .zero
        textView.isScrollEnabled = false
        return textView
    }()
}
