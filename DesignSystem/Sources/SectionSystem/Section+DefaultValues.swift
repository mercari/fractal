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
    public func pullData() { }
    public var itemCount: Int { return 0 }
    public var hasInputs: Bool { return false }

    public var sectionInsets: UIEdgeInsets { return .zero }
    public var minimumLineSpacing: CGFloat { return 0.0 }
    public var minimumInteritemSpacing: CGFloat { return 0.0 }
}

extension BedrockSection {

    public var itemCount: Int { return 1 }

    public var reuseIdentifier: String { return String(describing: self) }

    public func size(in view: UIView, at index: Int) -> SectionCellSize { return .automatic }

    public func height(in view: UIView, at index: Int) -> CGFloat? { return self.size(in: view, at: index).height }

    public func didSelect(_ view: UIView, at index: Int) { }
}

private struct AssociatedKeys {
    static var visibleViews = "ssVisibleViews"
    static var visibleViewControllers = "ssVisibleViewControllers"
}

extension ViewSection {

    public func configure(_ view: UIView, at index: Int) { }

    // MARK: - VisibleView

    private var mapTable: NSMapTable<NSNumber, UIView> {

        guard let mapTable = objc_getAssociatedObject(self, &AssociatedKeys.visibleViews) as? NSMapTable<NSNumber, UIView> else {
            let table = NSMapTable<NSNumber, UIView>(keyOptions: [.strongMemory], valueOptions: [.weakMemory])
            objc_setAssociatedObject(self, &AssociatedKeys.visibleViews, table, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return table
        }

        return mapTable
    }

    public var visibleView: UIView? {
        return mapTable.object(forKey: NSNumber(value: 0))
    }

    public var visibleViews: [UIView] {
        return mapTable.objectEnumerator()?.allObjects as? [UIView] ?? []
    }

    func set(visibleView: UIView?, at index: Int) {
        if visibleView == nil {
            mapTable.removeObject(forKey: NSNumber(value: index))
        } else {
            mapTable.setObject(visibleView, forKey: NSNumber(value: index))
        }
    }

    func decoupleVisibleViews() { mapTable.removeAllObjects() }

    func deleteVisibleViews() {
        for view in visibleViews {
            //TODO: make recursive search
            if let cell = view.superview?.superview as? SectionCollectionViewCell {
                cell.sectionView = nil
            } else if let cell = view.superview?.superview as? SectionTableViewCell {
                cell.sectionView = nil
            }
            
            view.removeFromSuperview()
        }
        mapTable.removeAllObjects()
    }
}

extension ViewControllerSection {

    public func configure(_ viewController: UIViewController, at index: Int) { }

    // MARK: - VisibleViewController

    private var mapTable: NSMapTable<NSNumber, UIViewController> {

        guard let mapTable = objc_getAssociatedObject(self, &AssociatedKeys.visibleViewControllers) as? NSMapTable<NSNumber, UIViewController> else {
            let table = NSMapTable<NSNumber, UIViewController>(keyOptions: [.strongMemory], valueOptions: [.weakMemory])
            objc_setAssociatedObject(self, &AssociatedKeys.visibleViewControllers, table, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return table
        }

        return mapTable
    }

    public var visibleViewController: UIViewController? {
        return mapTable.object(forKey: NSNumber(value: 0))
    }

    public var visibleViewControllers: [UIViewController] {
        return mapTable.objectEnumerator()?.allObjects as? [UIViewController] ?? []
    }

    func set(visibleViewController: UIViewController?, at index: Int) {
        if visibleViewController == nil {
            mapTable.removeObject(forKey: NSNumber(value: index))
        } else {
            mapTable.setObject(visibleViewController, forKey: NSNumber(value: index))
        }
    }

    func decoupleVisibleViewControllers() { mapTable.removeAllObjects() }

    func deleteVisibleViewControllers() {
        for vc in visibleViewControllers {
            
            //TODO: make recursive search
            if let cell = vc.view.superview?.superview?.superview as? SectionCollectionViewCell {
                cell.sectionViewController = nil
            } else if let cell = vc.view.superview?.superview?.superview as? SectionTableViewCell {
                cell.sectionViewController = nil
            }
            
            vc.willMove(toParent:nil)
            vc.view.superview?.removeFromSuperview()
            vc.view.removeFromSuperview()
            vc.removeFromParent()
        }
        
        mapTable.removeAllObjects()
    }
}

extension NestedSection {

    public var hasInputs: Bool { return allSections.filter { $0.hasInputs }.count > 0 }

    public func givenSectionIndex(from index: Int) -> Int? {
        var total = 0
        for section in givenSections {
            let sectionCount = section.itemCount
            if sectionCount + total > index {
                return index - total
            } else {
                total += sectionCount
            }
        }

        print("givenSectionIndex out of bounds")
        return nil
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
