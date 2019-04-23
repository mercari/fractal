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

    override func prepareForReuse() {
        super.prepareForReuse()

        if let visibleSection = section as? VisibleViewSection, let view = sectionView {
            visibleSection.viewBeingRecycled(view)
        } else if let visibleSection = section as? VisibleViewControllerSection, let viewController = sectionViewController {
            visibleSection.viewControllerBeingRecycled(viewController)
        }

        section = nil
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {

        if let section = section, let indexPath = indexPath, let size = section.size(in: contentView, at: indexPath.item) {
            var newFrame = layoutAttributes.frame
            newFrame.size.width = size.width
            newFrame.size.height = size.height
            layoutAttributes.frame = newFrame
            return layoutAttributes
        }

        return super.preferredLayoutAttributesFitting(layoutAttributes)
    }

    override var isHighlighted: Bool { didSet { (sectionView as? Highlightable)?.set(for: isHighlighted, selected: isSelected) } }
    override var isSelected: Bool { didSet { (sectionView as? Highlightable)?.set(for: isHighlighted, selected: isSelected) } }
}
