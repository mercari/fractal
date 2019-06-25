//
//  CollectionViewCell.swift
//  SectionSystem
//
//  Created by Anthony Smith on 11/09/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit

class SectionCollectionViewCell: UICollectionViewCell {

    weak var section: BedrockSection?
    var sectionView: UIView?
    var sectionViewController: UIViewController?
    var indexPath: IndexPath?

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {

        let size: SectionCellSize

        if let section = section, let indexPath = indexPath {
            size = section.size(in: contentView, at: indexPath.item)
        } else {
            size = .automatic
        }

        // The 1.0 here just needs to be bigger than zero
        // .defaultLow will override with the automatic size for us
        let newSize = CGSize(width: size.width ?? 1.0, height: size.height ?? 1.0)
        var newFrame = layoutAttributes.frame
        newFrame.size = newSize
        layoutAttributes.frame = newFrame
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(newSize,
                                                                          withHorizontalFittingPriority: size.width == nil ? .defaultLow : .required,
                                                                          verticalFittingPriority: size.height == nil ? .defaultLow : .required)
        return layoutAttributes
    }

    override var isHighlighted: Bool { didSet { (sectionView as? Highlightable)?.set(for: isHighlighted, selected: isSelected) } }
    override var isSelected: Bool { didSet { (sectionView as? Highlightable)?.set(for: isHighlighted, selected: isSelected) } }
}
