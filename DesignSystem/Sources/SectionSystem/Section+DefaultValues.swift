//
//  Section+DefaultValues.swift
//  SectionSystem
//
//  Created by anthony on 14/02/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation

extension Section {
    public func willReload() { }
    public var itemCount: Int { return 0 }

    public var itemInsets: UIEdgeInsets { return .zero }
    public var minimumLineSpacing: CGFloat { return 0.0 }
    public var minimumInteritemSpacing: CGFloat { return 0.0 }
}

extension BedrockSection {

    public var itemCount: Int { return 1 }

    public var reuseIdentifier: String { return String(describing: self) }

    public func size(in view: UIView, at index: Int) -> CGSize? { return nil }

    public func height(in view: UIView, at index: Int) -> CGFloat? { return self.size(in: view, at: index)?.height }

    public func didSelect(_ view: UIView, at index: Int) { }
}

extension ViewSection {
    public func configure(_ view: UIView, at index: Int) { }
}

extension ViewControllerSection {
    public func configure(_ viewController: UIViewController, at index: Int) { }
}

extension NestedSection {

    public func givenSectionIndex(from index: Int) -> Int {
        var total = 0
        for section in givenSections {
            let sectionCount = section.itemCount
            if sectionCount + total > index {
                return index - total
            } else {
                total += sectionCount
            }
        }

        Assert("givenSectionIndex out of bounds") // Should never happen.. make safe?
        return -1
    }

    public var reuseIdentifiers: [String]  {
        var ids = [String]()
        for section in givenSections {
            if let nestedSection = section as? NestedSection {
                ids.append(contentsOf: nestedSection.reuseIdentifiers)
            } else if let bedrockSection = section as? BedrockSection {
                ids.append(bedrockSection.reuseIdentifier)
            }
        }
        return ids
    }
}
