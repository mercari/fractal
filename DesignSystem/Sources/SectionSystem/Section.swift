//
//  Section.swift
//  SectionSystem
//
//  Created by Anthony Smith on 09/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit

public let defaultReuseIdentifier = "DefaultCell"

public protocol SectionBuilder {
    // This is the protocol for creating functions that return Sections
    // If you add this to the class where you create the array of sections you'll have access to all the convenience methods
    // This allows Section to be a protocol instead of a concrete type, also a readable API
}

public protocol Section: class { // Base for NestedSection and BedrockSection

    func willReload()
    func pullData()

    var itemCount: Int { get }
    var hasInputs: Bool { get }

    // CollectionView specific
    // Section level only sadly

    var sectionInsets: UIEdgeInsets { get }
    var minimumLineSpacing: CGFloat { get }
    var minimumInteritemSpacing: CGFloat { get }
}

public protocol NestedSection: Section {

    var allSections: [Section] { get }
    var givenSections: [Section] { get }
    var reuseIdentifiers: [String]  { get }

    func section(at index: Int) -> Section
    func givenSectionIndex(from index: Int) -> Int?
}

public protocol BedrockSection: Section { // Base for ViewSection and ViewControllerSection

    var reuseIdentifier: String { get }
    // Height automatically inherits from size.height
    // However you can override both for a different implementation on TableView and other SectionController types
    func size(in view: UIView, at index: Int) -> SectionCellSize
    func height(in view: UIView, at index: Int) -> CGFloat?

    func didSelect(_ view: UIView, at index: Int)
}

public protocol ViewSection: BedrockSection {
    func createView() -> UIView
    func configure(_ view: UIView, at index: Int)

    // Done automatically for you

    // Returns a UIView for a section if it is visible on the screen and configured
    var visibleView: UIView? { get }
    // Return an array of UIViews associated with this section, visible on the screen and configured
    var visibleViews: [UIView] { get }
}

public protocol ViewControllerSection: BedrockSection {
    func createViewController() -> UIViewController
    func configure(_ viewController: UIViewController, at index: Int)

    // Done automatically for you

    // Returns a UIViewController for a section if it is visible on the screen and configured
    var visibleViewController: UIViewController? { get }
    // Return an array of UIViewControllers associated with this section that are visible on the screen and configured
    var visibleViewControllers: [UIViewController] { get }
}

/// Used in func size(in view: UIView, at index: Int) -> SectionCellSize
/// and returned in lieu of CGSize in order to allow for some or total automatic cell sizing
/// SectionCellSize.automatic
/// lets the SectionCollectionViewController / SectionTableViewController calculate automatic width and height
/// SectionCellSize(width: someValue, height: nil)
/// lets the SectionCollectionViewController / SectionTableViewController calculate automatic height only
/// SectionCellSize(width: nil, height: someValue)
/// lets the SectionCollectionViewController / SectionTableViewController calculate automatic width
public struct SectionCellSize {
    
    public let width: CGFloat?
    public let height: CGFloat?
    
    public init() {
        width = nil
        height = nil
    }
    
    public init(width: CGFloat?, height: CGFloat?) {
        self.width = width
        self.height = height
    }
    
    public static var automatic: SectionCellSize {
        return SectionCellSize(width: nil, height: nil)
    }
}



