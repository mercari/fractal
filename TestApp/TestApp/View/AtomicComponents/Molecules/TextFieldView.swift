//
//  TextFieldView.swift
//  DesignSystem
//
//  Created by acantallops on 2019/04/19.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import DesignSystem

public class TextFieldView: UIView {

    let style: Style

    public enum Style: String {
        case plain, titled, icon
    }

    public enum Option { // Potentially make presets for email options, password options, etc.
        case returnKeyType(UIReturnKeyType),
        keyboardType(UIKeyboardType),
        autocorrectionType(UITextAutocorrectionType),
        spellCheckingType(UITextSpellCheckingType),
        autocapitalizationType(UITextAutocapitalizationType),
        secureTextEntry(Bool)
    }

    public init(style: Style) {
        self.style = style
        super.init(frame: .zero)

        backgroundColor = .background(.cell)
        addSubview(textField)
        pin([.height(BrandingManager.brand.defaultCellHeight, options: [.relation(.greaterThanOrEqual)])])

        switch style {
        case .plain:
            textField.pin(to: self, [.leading(.keyline),
                                     .top(.small),
                                     .bottom(-.small),
                                     .width(-.keyline*2, options: [.relation(.lessThanOrEqual)])])
        case .titled:
            addSubview(titleLabel)

            titleLabel.pin(to: self, [.leading(.keyline), .top(.small), .bottom(-.small)])
            titleLabel.pin(to: textField, [.leftOf(-.medium, options: [.relation(.lessThanOrEqual)])])


            textField.pin(to: self, [.trailing(-.keyline),
                                     .centerY,
                                     .width(options: [.multiplier(0.6), .relation(.equal)])])
        case .icon:
            textField.textAlignment = .right
            addSubview(iconImageView)
            iconImageView.pin(to: self, [.leading(.keyline),
                                         .centerY])
            textField.pin(to: self, [.leading(.keyline*2 + CGSize.mediumIcon.width, options: [.relation(.greaterThanOrEqual)]), // Assuming medium to keep them uniform
                                     .trailing(-.keyline),
                                     .top(.small),
                                     .bottom(-.small)])
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(title: String?,
                    icon: UIImage?,
                    placeholder: String?,
                    text: String?,
                    textFieldDelegate: UITextFieldDelegate?,
                    options: [Option]) {

        switch style {
        case .titled:
            titleLabel.text = title
        case .icon:
            iconImageView.image = icon
        default:
            break
        }

        textField.text = text
        textField.placeholder = placeholder
        textField.delegate = textFieldDelegate

        // Default option values
        textField.returnKeyType = .default
        textField.keyboardType = .default
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.autocapitalizationType = .words
        textField.isSecureTextEntry = false

        // If you add an option twice, the last value will be used
        for o in options {
            switch o {
            case .returnKeyType(let value):
                textField.returnKeyType = value
            case .keyboardType(let value):
                textField.keyboardType = value
            case .autocorrectionType(let value):
                textField.autocorrectionType = value
            case .spellCheckingType(let value):
                textField.spellCheckingType = value
            case .autocapitalizationType(let value):
                textField.autocapitalizationType = value
            case .secureTextEntry(let value):
                textField.isSecureTextEntry = value
            }
        }
    }

    public func set(text: String?) {
        textField.text = text
    }

    // MARK: - Overrides

    public override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }

    public override var isFirstResponder: Bool {
        return textField.isFirstResponder
    }

    // MARK: - Properties

    private lazy var titleLabel: Label = {
        let label = Label()
        label.apply(typography: .medium)
        return label
    }()

    private lazy var iconImageView: ImageView = {
        let imageView = ImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    public lazy var textField: TextField = {
        let textField = TextField()
        return textField
    }()
}
