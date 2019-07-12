//
//  ImageSection.swift
//  TestApp
//
//  Created by anthony on 12/07/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

extension SectionBuilder {
    func image(_ key: UIImage.Key, heightType: ImageSection.HeightType = .width) -> ImageSection {
        return ImageSection(key, heightType: heightType)
    }
}

class ImageSection {

    private let key: UIImage.Key
    private let heightType: HeightType

    enum HeightType {
        case width, height, custom(CGFloat)

        fileprivate func value(in view: UIView) -> CGFloat {
            switch self {
            case .width:
                return view.bounds.size.width
            case .height:
                return view.bounds.size.height
            case .custom(let value):
                return value
            }
        }
    }

    fileprivate init(_ key: UIImage.Key, heightType: ImageSection.HeightType) {
        self.key = key
        self.heightType = heightType
    }
}

extension ImageSection: ViewSection {

    var reuseIdentifier: String {
        switch heightType {
        case .width:
            return "ImageSection_width"
        case .height:
            return "ImageSection_height"
        case .custom(let value):
            return "ImageSection_custom_\(value)"
        }
    }

    public func createView() -> UIView {
        let imageView = ImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    public func size(in view: UIView, at index: Int) -> SectionCellSize {
        return SectionCellSize(width: view.bounds.size.width, height: heightType.value(in: view))
    }

    public func configure(_ view: UIView, at index: Int) {
        (view as? ImageView)?.image = UIImage.with(key)
    }
}
