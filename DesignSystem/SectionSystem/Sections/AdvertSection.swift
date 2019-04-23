//
//  AdvertSection.swift
//  SectionSystem
//
//  Created by anthony on 22/04/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation


public protocol AdvertData {
    var url: URL? { get }
    var image: UIImage? { get } // TODO: Change to URL
    var height: CGFloat? { get }
}

extension SectionBuilder {
    public func advert(_ data: AdvertData, padding: CGFloat = .keyline) -> AdvertSection {
        return AdvertSection(data, padding: padding)
    }
}

public class AdvertSection {
    fileprivate let data: AdvertData
    fileprivate let padding: CGFloat
    fileprivate static let defaultHeight: CGFloat = 44.0

    public init(_ data: AdvertData, padding: CGFloat = .keyline) {
        self.data = data
        self.padding = padding
    }
}

extension AdvertSection: ViewSection {

    public var reuseIdentifier: String {
        return "Advert_\(padding)"
    }

    public func createView() -> UIView {
        return AdvertView()
    }

    public func configure(_ view: UIView, at index: Int) {
        (view as? AdvertView)?.set(image: data.image)
    }

    public func size(in view: UIView, at index: Int) -> CGSize? {
        return CGSize(width: view.bounds.size.width - padding*2, height: data.height ?? AdvertSection.defaultHeight)
    }

    public func didSelect(_ view: UIView, at index: Int) {
        guard let url = data.url else { return }
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    public var itemInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: padding, bottom: 0.0, right: padding)
    }
}
