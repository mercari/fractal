//
//  Button+BrandingManager.swift
//  Mercari
//
//  Created by Anthony Smith on 29/08/2018.
//  Copyright © 2018 Mercari, Inc. All rights reserved.
//

import UIKit

public protocol ButtonBrand {
    func widthPin(for style: Button.Style) -> Pin
    func heightPin(for style: Button.Style) -> Pin
    func configure(_ button: Button, with style: Button.Style)
}

extension Button {

    public enum Style {

        case primary(size: Size),
        secondary(size: Size),
        attention(size: Size),
        toggle(size: Size),
        textLink(size: Size),
        facebook(size: Size),
        google(size: Size)

        static var `default`: Style {
            return .primary(size: Size(width: .natural, height: .medium))
        }

        public struct Size {

            public let width: Width
            public let height: Height

            public init(width: Width, height: Height) {
                self.width = width
                self.height = height
            }

            public enum Width {
                case full, half, natural, custom(CGFloat)

                public var name: String {
                    switch self {
                    case .full:
                        return "full"
                    case .half:
                        return "half"
                    case .natural:
                        return "natural"
                    case .custom(let constant):
                        return "custom_\(constant)"
                    }
                }
            }

            public enum Height: String {
                case small, medium, large, natural
            }
        }

        // MARK: - Values

        public var name: String {

            let name: String
            let styleSize: Size

            switch self {
            case .primary(let size):
                name = "primary"
                styleSize = size
            case .secondary(let size):
                name = "secondary"
                styleSize = size
            case .attention(let size):
                name = "attention"
                styleSize = size
            case .toggle(let size):
                name = "toggle"
                styleSize = size
            case .textLink(let size):
                name = "textLink"
                styleSize = size
            case .facebook(let size):
                name = "facebook"
                styleSize = size
            case .google(let size):
                name = "google"
                styleSize = size
            }

            return "\(name)_\(styleSize.width.name)_\(styleSize.height.rawValue)"
        }
    }
}
