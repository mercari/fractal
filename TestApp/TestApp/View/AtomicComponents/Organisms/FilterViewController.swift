//
//  FilterControllerView.swift
//  DesignSystem
//
//  Created by jbergier on 2019/04/16.
//  Copyright © 2019 mercari. All rights reserved.
//

import UIKit

public protocol FilterController {
    /// Returns raw search string. Returns "" when there is no search.
    /// Consumer of this API should do the work to trim and normalize the string
    /// based on the kind of data they are searching.
    var currentFilter: String { get }
    /// Whenever the filter changes, this closure is executed so the consumer
    /// of this API can update their UI.
    var filterChanged: ((String) -> Void)? { get set }
}

public typealias FilterViewControllerType = UISearchController & FilterController

/// UISearchController with a unified style that can be used anywhere in the app.
public class FilterViewController: UISearchController, FilterController {

    public var filterChanged: ((String) -> Void)?

    public init() {
        super.init(searchResultsController: nil)
        self.configureDesign()
    }

    // Required to implement manually or else a crash occurs.
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.configureDesign()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureDesign()
    }

    private func configureDesign() {
        searchResultsUpdater = self
        dimsBackgroundDuringPresentation = false
        hidesNavigationBarDuringPresentation = false
    }

    public var currentFilter: String {
        return self.searchBar.text ?? ""
    }
}

extension FilterViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        self.filterChanged?(self.currentFilter)
    }
}
