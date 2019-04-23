//
//  Label.swift
//  Mercari
//
//  Created by Shinichiro Oba on 21/06/2018.
//  Copyright © 2018 Mercari, Inc. All rights reserved.
//

import UIKit

final public class Label: UILabel {

    public var typography: BrandingManager.Typography = .medium { didSet { lineHeight = numberOfLines == 1 ? 0.0 : typography.lineHeight } }
    public var actualLineHeight: CGFloat { return max(lineHeight, font.lineHeight) }
    public var underlineStyle: NSUnderlineStyle = [] { didSet { update() } }
    public var letterSpace: CGFloat = 0.0 { didSet { update() } }
    public var lineHeight: CGFloat = 0.0 { didSet { update() } }

    override public var font: UIFont! { get { return typography.font } set { } }
    override public var text: String? { didSet { update() } }
    override public var textAlignment: NSTextAlignment { didSet { update() } }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        _ = NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: BrandingManager.didChange), object: nil, queue: nil) { [weak self] (_) in
            self?.update()
        }
    }

    public func apply(typography: BrandingManager.Typography, color: UIColor? = nil) {
        self.typography = typography
        textColor = color ?? typography.defaultColor
    }

    private func update() {

        guard let text = text else { attributedText = nil; return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment
        paragraphStyle.lineBreakMode = .byTruncatingTail

        var attr = [NSAttributedString.Key: Any]()
        attr[.font] = typography.font
        attr[.foregroundColor] = textColor
        attr[.paragraphStyle] = paragraphStyle
        attr[.underlineStyle] = underlineStyle.rawValue
        attr[.kern] = letterSpace

        attributedText = NSAttributedString(string: text, attributes: attr)
    }

    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        update()
    }
}
