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
                let section = data.sections[index]
                section.willReload()
                if let n = section as? NestedSection { notifyNestOfReload(n) }
            }
        } else {
            for section in data.sections {
                section.willReload()
                if let n = section as? NestedSection { notifyNestOfReload(n) }
            }
        }

        DispatchQueue.main.async {

            if indexes.count > 0 {
                UIView.performWithoutAnimation {
                    self.tableView.reloadSections(IndexSet(indexes), with: .none)
                }
                return
            }

            guard self.useRefreshControl else { self.tableView.reloadData(); return }

            if self.refreshControl?.isRefreshing ?? false {
                self.refreshControl?.perform(#selector(self.refreshControl?.endRefreshing), with: nil, afterDelay: 0.5, inModes: [RunLoop.Mode.common])
                self.tableView.perform(#selector(self.tableView.reloadData), with: nil, afterDelay: 0.8, inModes: [RunLoop.Mode.common])
            } else {
                self.tableView.reloadData()
            }
        }
    }

    private func notifyNestOfReload(_ nestedSection: NestedSection) {
        for section in nestedSection.allSections {
            section.willReload()
            if let n = section as? NestedSection { notifyNestOfReload(n) }
        }
    }
}

public class SectionTableViewController: UITableViewController {

    private let useRefreshControl: Bool
    private var registeredReuseIdentifiers: Set<String> = [defaultReuseIdentifier]
    private var data: SectionControllerDataSource!
    public var refresh: (() -> Void)?
    public init(useRefreshControl: Bool = false) {
        self.useRefreshControl = useRefreshControl
        super.init(style: .plain)
        data = SectionControllerDataSource(viewController: self)
    }
    public var didScrollClosure: ((UIScrollView) -> Void)? {
        get { return data.didScroll }
        set { data.didScroll = newValue }
    }

    public override func viewDidLoad() {
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
