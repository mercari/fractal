//
//  TextViewSection.swift
//  SectionSystem
//
//  Created by anthony on 07/05/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

extension SectionBuilder {
    public func textView(key: String, placeholder: String? = nil, observedText: Observable<String?>, delegate: TextFieldSectionDelegate? = nil, options: [TextViewView.Option] = []) -> TextViewSection {
        return TextViewSection(key: key, placeholder: placeholder, observedText: observedText, delegate: delegate, options: options)
    }
}

public class TextViewSection: NSObject {

    fileprivate let key: String
    fileprivate let placeholder: String?
    fileprivate let options: [TextViewView.Option]
    fileprivate weak var observedText: Observable<String?>?
    fileprivate weak var delegate: TextFieldSectionDelegate?

    init(key: String, placeholder: String?, observedText: Observable<String?>, delegate: TextFieldSectionDelegate?, options: [TextViewView.Option]) {
        self.key = key
        self.placeholder = placeholder
        self.observedText = observedText
        self.delegate = delegate
        self.options = options

        super.init()
        self.observedText?.addObserver(self) { [weak self] newValue in
            guard let view = self?.visibleView as? TextViewView else { return }
            if !view.isFirstResponder {
                view.set(text: newValue)
            }
        }
    }
}

extension TextViewSection: ViewSection {

    public var hasInputs: Bool { return true }

    public func createView() -> UIView {
        return TextViewView()
    }

    public func configure(_ view: UIView, at index: Int) {
        guard let textViewView = view as? TextViewView else { return }
        textViewView.set(text: observedText?.value)
        textViewView.set(delegate: self, placeholder: placeholder, options: options)
    }

    public func size(in view: UIView, at index: Int) -> SectionCellSize {
        let text = observedText?.value ?? placeholder ?? " "
        let textHeight = text.height(typography: TextViewView.typography, width: view.bounds.size.width - .keyline*2)
        return SectionCellSize(width: view.bounds.size.width, height: max(BrandingManager.brand.defaultCellHeight, textHeight + .small*2))
    }

    public func didSelect(_ view: UIView, at index: Int) {
        _ = (self.visibleView as? TextViewView)?.becomeFirstResponder()
    }
}

extension TextViewSection: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        observedText?.value = textView.text
        let size = textView.bounds.size
        let newHeight = textView.sizeThatFits(CGSize(width: size.width, height: .greatestFiniteMagnitude)).height
        if size.height != newHeight { requestLayout() }
    }
}

extension TextViewView: InputChain {
    public var inputResponders: [UIResponder] {
        return [textView]
    }

    public func triggerNext(after responder: UIResponder?) -> Bool {
        guard responder !== textView else { return false }
        return textView.becomeFirstResponder()
    }
}
