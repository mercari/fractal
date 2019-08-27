//
//  TableViewCell.swift
//  SectionSystem
//
//  Created by anthony on 11/12/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit

class SectionTableViewCell: UITableViewCell {

    weak var sectionViewController: UIViewController?
    weak var sectionView: UIView?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: highlighted || isSelected ? .curveEaseIn : .curveEaseOut, animations: {
                self.update(for: highlighted, selected: self.isSelected)
            })
        } else {
            update(for: highlighted, selected: isSelected)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: isHighlighted || selected ? .curveEaseIn : .curveEaseOut, animations: {
                self.update(for: self.isHighlighted, selected: selected)
            })
        } else {
            update(for: isHighlighted, selected: selected)
        }
    }

    private func update(for highlighted: Bool, selected: Bool) {
        (sectionView as? Highlightable)?.set(for: highlighted, selected: selected)
    }
}
