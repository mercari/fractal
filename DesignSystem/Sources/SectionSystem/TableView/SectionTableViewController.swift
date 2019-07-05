//
//  SectionTableViewController.swift
//  SectionSystem
//
//  Created by anthony on 11/12/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit

extension SectionTableViewController: SectionController {

    public var dataSource: SectionControllerDataSource { return data }

    public var didPullDownToRefreshClosure: (() -> Void)? {
        get { return refresh }
        set { refresh = newValue }
    }

    open func reloadSections(at indexes: [Int]) {

        if self.data.newSections {
            self.data.registerCells(in: self.tableView, with: &self.registeredReuseIdentifiers)
        }

        if indexes.count > 0 {
            for index in indexes {
                guard index < data.sections.count else { continue }
                let section = data.sections[index]
                if let n = section as? NestedSection { notifyNestOfReload(n) }
                section.willReload()
            }
        } else {
            for section in data.sections {
                if let n = section as? NestedSection { notifyNestOfReload(n) }
                section.willReload()
            }
        }

        DispatchQueue.main.async {

            guard self.useRefreshControl else {

                if indexes.count > 0 {
                    UIView.performWithoutAnimation { self.tableView.reloadSections(IndexSet(indexes), with: .none) }
                } else {
                    self.tableView.reloadData()
                }

                return
            }

            if self.refreshControl?.isRefreshing ?? false {
                self.perform(#selector(self.reloadRefresh), with: nil, afterDelay: 0.4, inModes: [RunLoop.Mode.common])
            } else {

                if indexes.count > 0 {
                    UIView.performWithoutAnimation { self.tableView.reloadSections(IndexSet(indexes), with: .none) }
                } else {
                    self.tableView.reloadData()
                }
            }
        }
    }

    @objc private func reloadRefresh() {
        tableView.reloadData()
        refreshControl?.perform(#selector(refreshControl?.endRefreshing), with: nil, afterDelay: 0.1, inModes: [RunLoop.Mode.common])
    }

    private func notifyNestOfReload(_ nestedSection: NestedSection) {
        for section in nestedSection.allSections {
            section.willReload()
            if let n = section as? NestedSection { notifyNestOfReload(n) }
        }
    }
}

open class SectionTableViewController: UITableViewController {

    private let useRefreshControl: Bool
    private var registeredReuseIdentifiers: Set<String> = []
    private var data: SectionControllerDataSource!
    private var configureTableView: ((UITableView) -> Void)?
    public var refresh: (() -> Void)?

    public init(useRefreshControl: Bool = false, configureTableView: ((UITableView) -> Void)? = nil) {
        self.useRefreshControl = useRefreshControl
        self.configureTableView = configureTableView
        super.init(style: .plain)
        data = SectionControllerDataSource(viewController: self)
    }
    public var didScrollClosure: ((UIScrollView) -> Void)? {
        get { return data.didScroll }
        set { data.didScroll = newValue }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        if useRefreshControl {
            let control = UIRefreshControl()
            control.addTarget(self, action: #selector(refreshTriggered), for: .valueChanged)
            control.tintColor = refreshControlTintColor
            refreshControl = control
        } else {
            tableView.alwaysBounceVertical = false
        }
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = data
        tableView.delegate = data
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.alwaysBounceVertical = true
        tableView.keyboardDismissMode = .interactive

        configureTableView?(tableView)
    }

    @available (*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc open func refreshTriggered() {
        didPullDownToRefreshClosure?()
    }
    
    // MARK: - Accessors

    open var refreshControlTintColor: UIColor {
        return .atom(.refreshControl)
    }
}
