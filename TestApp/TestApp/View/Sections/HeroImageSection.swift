//
//  HeroImageSection.swift
//  TestApp
//
//  Created by Anthony Smith on 05/09/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

extension SectionBuilder {
    
    public func heroImage(_ image: @autoclosure @escaping () -> UIImage?) -> HeroImageSection {
        return HeroImageSection(imageClosure: image)
    }
}

public class HeroImageSection {

    fileprivate let imageClosure: () -> UIImage?
    
    public init(imageClosure: @escaping () -> UIImage?) {
        self.imageClosure = imageClosure
    }
}

extension HeroImageSection: ViewSection {
    
    public func createView() -> UIView {        
        return HeroImageView()
    }
    
    public func size(in view: UIView, at index: Int) -> SectionCellSize {
        return SectionCellSize(width: view.bounds.size.width, height: view.bounds.size.width)
    }
    
    public func configure(_ view: UIView, at index: Int) {
        (view as? HeroImageView)?.set(image: imageClosure())
    }
}
