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
        return NavigationSection(style, selectionClosure: selectionClosure).enumerate(optionsClosure) as! NavigationSection
    }
}

extension NavigationSection: EnumeratableSection {
    public typealias DataType = NavigationOption
}

public class NavigationSection {

    fileprivate let style: NavigationOptionView.Style
    fileprivate let selectionClosure: (Int, NavigationOption) -> Void

    public init(_ style: NavigationOptionView.Style = .default, selectionClosure: @escaping (Int, NavigationOption) -> Void) {
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

    public func createView() -> UIView {
        return NavigationOptionView(style: style)
    }

    public func size(in view: UIView, at index: Int) -> SectionCellSize {

        switch style {
        case .detail:

            let option = data[index]
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

    public func configure(_ view: UIView, at index: Int) {
        let option = data[index]
        (view as? NavigationOptionView)?.set(title: option.title, detail: option.detail)
    }

    public func didSelect(_ view: UIView, at index: Int) {
        let option = data[index]
        selectionClosure(index, option)
    }
}
