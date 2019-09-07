//
//  FilteringTableViewController.swift
//  DesignSystemApp
//
//  Created by jbergier on 2019/04/16.
//  Copyright © 2019 mercari. All rights reserved.
//

import UIKit
import DesignSystem

class FilteringTableViewController: UIViewController, SectionBuilder {

    let sectionController: SectionViewController = SectionTableViewController()
    var filterController: FilterViewControllerType = FilterViewController()

    let data: [CheckboxOption] = [
        "Lorem ipsum dolor sit",
        "dolor sit amet, consectetur",
        "consectetur adipiscing elit",
        "elit. Nunc eu laoreet massa",
        "massa. Aliquam accumsan",
        "accumsan ultricies cursus"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .background
        self.title = "Filter"

        guard #available(iOS 11.0, *) else { fatalError("This sample app only works on iOS 11+") }

        self.navigationItem.searchController = self.filterController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.contain(self.sectionController)
        self.bind()
        sectionController.reload()
    }

    private func bind() {
        self.sectionController.dataSource.sections = [
            group([checkboxOptions({ [data, fc = filterController] in
                return (-1, data.filter { $0.title.search(fc.currentFilter) })
                }, selectionClosure: { _, _ in })]),
        ]

        self.filterController.filterChanged = { [sectionController] _ in
            sectionController.reload()
        }
    }
}

extension String: CheckboxOption {
    public var id: String {
        return self
    }
    public var title: String {
        return self
    }
    public var detail: String? {
        return nil
    }

    func search(_ _rhs: String) -> Bool {
        let rhs = _rhs.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard rhs.isEmpty == false else { return true }
        let lhs = self.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return lhs.contains(rhs)
    }
}
