//
//  NavigationSection.swift
//  SectionSystem
//
//  Created by anthony on 19/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import DesignSystem

public protocol NavigationOption {
    var title: String { get }
    var detail: String? { get }
    var intent: String? { get }
}

extension SectionBuilder {
    public func navigationOptions(_ optionsClosure: @escaping () -> [NavigationOption], style: NavigationOptionView.Style = .default, selectionClosure:  @escaping (Int, NavigationOption) -> Void) -> NavigationSection {
        return NavigationSection(optionsClosure, style: style, selectionClosure: selectionClosure)
    }
}

public class NavigationSection {
    fileprivate let optionsClosure: () -> [NavigationOption]
    fileprivate var staticOptions: [NavigationOption]
    fileprivate let style: NavigationOptionView.Style
    fileprivate let selectionClosure: (Int, NavigationOption) -> Void

    public init(_ optionsClosure: @escaping () -> [NavigationOption], style: NavigationOptionView.Style = .default, selectionClosure: @escaping (Int, NavigationOption) -> Void) {
        self.optionsClosure = optionsClosure
        self.staticOptions = optionsClosure()
        self.style = style
        self.selectionClosure = selectionClosure
    }
}

extension NavigationSection: ViewSection {

    public var reuseIdentifier: String {
        switch style {
        case .default:
            return "Navigation_Default"
        case .detail:
            return "Navigation_Detail"
        case .information(let constant):
            return "Navigation_Information_\(constant)"
        }
    }

    public func willReload() {
        staticOptions = optionsClosure()
    }

    public func createView() -> UIView {
        return NavigationOptionView(style: style)
    }

    public func size(in view: UIView, at index: Int) -> SectionCellSize {

        switch style {
        case .detail:

            let option = staticOptions[index]
            let textWidth = view.bounds.size.width - (.keyline*2 + .small + NavigationOptionView.detailDisclosureWidth)
            var textHeight = option.title.height(typography: NavigationOptionView.typography, width: textWidth, maxLines: 3)

            if let detail = option.detail {
                textHeight += detail.height(typography: NavigationOptionView.typography, width: textWidth, maxLines: 3)
                textHeight += .small
            }

            return SectionCellSize(width: view.bounds.size.width, height: max(BrandingManager.brand.defaultCellHeight, textHeight + .small*2))
        default:
            break
        }

        return SectionCellSize(width: view.bounds.size.width, height: nil)
    }

    public var itemCount: Int {
        return staticOptions.count
    }

    public func configure(_ view: UIView, at index: Int) {
        let option = staticOptions[index]
        (view as? NavigationOptionView)?.set(title: option.title, detail: option.detail)
    }

    public func didSelect(_ view: UIView, at index: Int) {
        let option = staticOptions[index]
        selectionClosure(index, option)
    }
}
