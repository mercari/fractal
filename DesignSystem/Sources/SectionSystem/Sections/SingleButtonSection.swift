//
//  ButtonComponentViewModel.swift
//  SectionSystem
//
//  Created by Anthony Smith on 09/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation


extension SectionBuilder {
    public func singleButton(_ title: String, style: SingleButtonSection.Style = .primary, hiddenClosure: (() -> Bool)? = nil, tappedClosure: @escaping () -> Void, selectedClosure: (() -> Bool)? = nil) -> SingleButtonSection {
        return SingleButtonSection(title, style: style, hiddenClosure: hiddenClosure, tappedClosure: tappedClosure, selectedClosure: selectedClosure)
    }
}

public class SingleButtonSection {

    public enum Style {
        case primary, secondary, attention, toggle, textLink, facebook, google

        public var name: String {
            switch self {
            case .primary:
                return "SingleButton_Primary"
            case .secondary:
                return "SingleButton_Secondary"
            case .attention:
                return "SingleButton_Attention"
            case .toggle:
                return "SingleButton_Toggle"
            case .textLink:
                return "SingleButton_TextLink"
            case .facebook:
                return "SingleButton_Facebook"
            case .google:
                return "SingleButton_Google"
            }
        }

        public var buttonStyle: Button.Style {
            let size = Button.Style.Size(width: .full, height: .large)
            switch self {
            case .primary:
                return Button.Style.primary(size: size)
            case .secondary:
                return Button.Style.secondary(size: size)
            case .attention:
                return Button.Style.attention(size: size)
            case .toggle:
                return Button.Style.toggle(size: size)
            case .textLink:
                return Button.Style.textLink(size: size)
            case .facebook:
                return Button.Style.facebook(size: size)
            case .google:
                return Button.Style.google(size: size)
            }
        }
    }

    fileprivate let title: String
    fileprivate let style: Style
    fileprivate let hiddenClosure: (() -> Bool)?
    fileprivate let tappedClosure: () -> Void
    fileprivate let selectedClosure: (() -> Bool)?

    init(_ title: String, style: SingleButtonSection.Style = .primary, hiddenClosure: (() -> Bool)? = nil, tappedClosure: @escaping () -> Void, selectedClosure: (() -> Bool)? = nil) {
        self.title = title
        self.style = style
        self.hiddenClosure = hiddenClosure
        self.tappedClosure = tappedClosure
        self.selectedClosure = selectedClosure
    }
}

extension SingleButtonSection: ViewSection {
    public var reuseIdentifier: String {
        return style.name
    }

    public func createView() -> UIView {
        return SingleButtonView(style: style.buttonStyle)
    }

    public var itemCount: Int {
        guard let hiddenClosure = self.hiddenClosure else { return 1 }
        return hiddenClosure() ? 0 : 1
    }

    public func configure(_ view: UIView, at index: Int) {
        (view as? SingleButtonView)?.set(buttonTitle: self.title, selected: self.selectedClosure?() ?? false, closure: self.tappedClosure)
    }
}
