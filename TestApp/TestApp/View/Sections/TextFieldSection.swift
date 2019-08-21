//
//  TextFieldSection.swift
//  SectionSystem
//
//  Created by acantallops on 2019/04/19.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

extension SectionBuilder {
    public func textField(key: String,
                          title: String? = nil,
                          icon: UIImage? = nil,
                          placeholder: String? = nil,
                          observedText: Observable<String?>,
                          delegate: TextFieldSectionDelegate? = nil,
                          options: [TextFieldView.Option] = []) -> TextFieldSection {
        return TextFieldSection(key: key,
                                title: title,
                                icon: icon,
                                placeholder: placeholder,
                                observedText: observedText,
                                delegate: delegate,
                                options: options)
    }
}

public protocol TextFieldSectionDelegate: class {
    func returnButtonPushed(textField: UITextField, key: String)
    func didEndEditing(textField: UITextField, key: String)
}

public class TextFieldSection: NSObject {

    fileprivate let key: String
    fileprivate let title: String?
    fileprivate let icon: UIImage?
    fileprivate let placeholder: String?
    fileprivate weak var observedText: Observable<String?>?
    fileprivate weak var delegate: TextFieldSectionDelegate?
    fileprivate let style: TextFieldView.Style
    fileprivate let options: [TextFieldView.Option]

    init(key: String,
        title: String?,
        icon: UIImage?,
        placeholder: String?,
        observedText: Observable<String?>,
        delegate: TextFieldSectionDelegate?,
        options: [TextFieldView.Option]
    ) {
        self.key = key
        self.title = title
        self.icon = icon
        self.placeholder = placeholder
        self.observedText = observedText
        self.delegate = delegate
        self.style = title != nil ? .titled: (icon != nil ? .icon: .plain)
        self.options = options
        super.init()
        self.observedText?.addObserver(self) { [weak self] newValue in
            guard let view = self?.visibleView as? TextFieldView else { return }
            guard !view.isFirstResponder else { return }
            view.set(text: newValue)
        }
    }
}

extension TextFieldSection: ViewSection {

    public var hasInputs: Bool { return true }

    public var reuseIdentifier: String {
        return "TextFieldSection_\(style.rawValue)"
    }

    public func createView() -> UIView {
        return TextFieldView(style: style)
    }

    public func size(in view: UIView, at index: Int) -> SectionCellSize {
        return SectionCellSize(width: view.bounds.size.width, height: nil)
    }
    
    public func configure(_ view: UIView, at index: Int) {
        // Nice to have: if we have a nextInput and the consumer hasn't set a return key type and it's a textfield or textview,
        // we could write something automatically set the return key to next.
        guard let textfieldView = view as? TextFieldView else { return }
        textfieldView.set(title: title, icon: icon, placeholder: placeholder, text: observedText?.value, textFieldDelegate: self, options: options)
    }

    public func didSelect(_ view: UIView, at index: Int) {
        _ = (self.visibleView as? TextFieldView)?.becomeFirstResponder()
    }
}

extension TextFieldSection: UITextFieldDelegate {

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard string != "\n" else {

            if let delegate = delegate {
                delegate.returnButtonPushed(textField: textField, key: key)
            } else {
                switch textField.returnKeyType {
                case .default, .done:
                    textField.resignFirstResponder()
                case .next:
                    textField.notifyNextInput()
                default:
                    print("Currently no default behaviour for this case, please implement TextFieldSectionDelegate")
                    break
                }
            }

            return false
        }

        let text = textField.text ?? ""
        var updatedTextString: NSString = text as NSString
        updatedTextString = updatedTextString.replacingCharacters(in: range, with: string) as NSString
        observedText?.value = updatedTextString as String
        return true
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didEndEditing(textField: textField, key: key)
    }
}

extension TextFieldView: InputChain {
    public var inputResponders: [UIResponder] {
        return [textField]
    }

    public func triggerNext(after responder: UIResponder?) -> Bool {
        guard responder !== textField else { return false }
        return textField.becomeFirstResponder()
    }
}
