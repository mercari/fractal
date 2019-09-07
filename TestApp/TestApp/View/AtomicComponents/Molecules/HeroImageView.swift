//
//  HeroImageView.swift
//  TestApp
//
//  Created by Anthony Smith on 07/09/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

protocol HeroImageBrand {
    var heroCornerRadius: CGFloat { get }
    var heroEdgeInsets: UIEdgeInsets { get }
}

public extension UIColor.Key {
    static let heroBg = UIColor.Key("heroBg")
}

class HeroImageView: UIView {
    
    init() {
        super.init(frame: .zero)
        addSubview(imageView)
        
        let insets = (BrandingManager.brand as? HeroImageBrand)?.heroEdgeInsets ?? .zero
        imageView.backgroundColor = .background(.heroBg)
        
        imageView.pin(to: self, [.leading(insets.left),
                                 .top(insets.top),
                                 .trailing(-insets.right),
                                 .bottom(-insets.bottom)])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(image: UIImage?) {
        imageView.image = image
    }
    
    // MARK: - Properties
    
    private var imageView: ImageView = {
        let imageView = ImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = (BrandingManager.brand as? HeroImageBrand)?.heroCornerRadius ?? 0.0
        return imageView
    }()
}
