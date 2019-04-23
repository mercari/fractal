//
//  Section.swift
//  SectionSystem
//
//  Created by Anthony Smith on 09/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation

let defaultReuseIdentifier = "DefaultCell"

public protocol SectionBuilder {
    // This is the protocol for creating functions that return Sections
    // If you add this to the class where you create the array of sections you'll have access to all the convenience methods
    // This allows Section to be a protocol instead of a concrete type, also a readable API
}

public protocol Section: class { // Base for NestedSection and BedrockSection

    func willReload()
    var itemCount: Int { get }

    // CollectionView specific
    // Section level only sadly

    var itemInsets: UIEdgeInsets { get }
    var minimumLineSpacing: CGFloat { get }
    var minimumInteritemSpacing: CGFloat { get }
}

public protocol NestedSection: Section {

    var allSections: [Section] { get }
    var givenSections: [Section] { get }
    var reuseIdentifiers: [String]  { get }

    func section(at index: Int) -> Section
    func givenSectionIndex(from index: Int) -> Int
}

public protocol BedrockSection: Section { // Base for ViewSection and ViewControllerSection

    var reuseIdentifier: String { get }

    // Height automatically inherits from size.height
    // However you can override both for a different implementation on TableView and other SectionController types
    func size(in view: UIView, at index: Int) -> CGSize?
    func height(in view: UIView, at index: Int) -> CGFloat?

    func didSelect(_ view: UIView, at index: Int)
}

public protocol ViewSection: BedrockSection {
    func createView() -> UIView
    func configure(_ view: UIView, at index: Int)
}

public protocol ViewControllerSection: BedrockSection {
    func createViewController() -> UIViewController
    func configure(_ viewController: UIViewController, at index: Int)
}

public protocol VisibleViewSection: class {

    // Return a UIView when it is visible on the screen and configured
    // Capture the view weakly on 'configure' and return it here
    // For non-reuse Controllers this will always return a value on or off the screen
    var visibleView: UIView? { get } //TODO: this could probably be automatic

    // Returns an array of UIViews when it is visible on the screen and configured
    // Capture the view weakly on 'configure' and return it here
    // For non-reuse Controllers this will always return a value on or off the screen
    var visibleViews: [UIView]? { get } //TODO: this could probably be automatic

    // Use this method to decouple the visibleView
    func viewBeingRecycled(_ view: UIView)
}

public protocol VisibleViewControllerSection: class {

    // Return a UIViewController when it is visible on the screen and configured
    // Capture the viewController weakly on 'configure' and return it here
    // For non-reuse Controllers this will always return a value on or off the screen
    var visibleViewController: UIViewController? { get }

    // Return an array of UIViewController when it is visible on the screen and configured
    // Capture the viewController weakly on 'configure' and return it here
    // For non-reuse Controllers this will always return a value on or off the screen
    var visibleViewControllers: [UIViewController]? { get }

    // Use this method to decouple the visibleViewController
    func viewControllerBeingRecycled(_ viewController: UIViewController)
}
