//
//  ButtonCarouselSection.swift
//  TestApp
//
//  Created by Anthony Smith on 04/09/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

extension SectionBuilder {
    
    public func buttonCarousel(with titles: @autoclosure @escaping () -> [String], selectionClosure:  @escaping (Int) -> Void) -> CarouselSection {
        let sections = [buttonArray(titles: titles(), selectionClosure: selectionClosure)]
        return carousel(sections: sections, height: ButtonArraySection.height, pagingEnabled: false)
    }
    
    public func buttonArray(titles: @autoclosure @escaping () -> [String], selectionClosure:  @escaping (Int) -> Void) -> ButtonArraySection {
        return ButtonArraySection(selectionClosure: selectionClosure).enumerate(titles) as! ButtonArraySection
    }
}

extension ButtonArraySection: EnumeratableSection {
    public typealias DataType = String
}

public class ButtonArraySection {
    
    fileprivate static let buttonHeightType: Button.Size.Height = .medium
    fileprivate static var height: CGFloat {
        
        guard let height = (BrandingManager.brand as? ButtonBrand)?.height(for: ButtonArraySection.buttonHeightType) else {
            print("BrandingManager.brand does not conform to ButtonBrand")
            return 44.0
        }
        
        return height
    }
    fileprivate let selectionClosure: (Int) -> Void
    
    public init(selectionClosure: @escaping (Int) -> Void) {
        self.selectionClosure = selectionClosure
    }
}

extension ButtonArraySection: ViewSection {
    
    public func createView() -> UIView {
        return Button.init(style: .secondary)
    }
    
    public func size(in view: UIView, at index: Int) -> SectionCellSize {
        return SectionCellSize(width: nil, height: ButtonArraySection.height)
    }
    
    public func configure(_ view: UIView, at index: Int) {
        let title = data[index]
        (view as? Button)?.setTitle(title, for: .normal)
    }
    
    public func didSelect(_ view: UIView, at index: Int) {
        selectionClosure(index)
    }
    
    public var sectionInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: .keyline, bottom: 0.0, right: .keyline)
    }
    
    public var minimumInteritemSpacing: CGFloat {
        return .medium
    }
    
    public var minimumLineSpacing: CGFloat {
        return .medium
    }
    
}
