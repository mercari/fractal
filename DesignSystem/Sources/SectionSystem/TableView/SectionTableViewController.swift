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

        if data.newSections {
            data.registerCells(in: self.tableView, with: &self.registeredReuseIdentifiers)
        }

        data.notifySectionsOfReload(in: indexes)

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
}

open class SectionTableViewController: UITableViewController {

    private let useRefreshControl: Bool
    private var registeredReuseIdentifiers: Set<String> = []
    private var data: SectionControllerDataSource!
    private var configureTableView: ((UITableView) -> Void)?
    private var notificationObject: NSObjectProtocol?
    public var refresh: (() -> Void)?
    public var tearDownOnBrandChange: Bool = true

    public init(useRefreshControl: Bool = false, configureTableView: ((UITableView) -> Void)? = nil) {
        self.useRefreshControl = useRefreshControl
        self.configureTableView = configureTableView
        super.init(style: .plain)
        data = SectionControllerDataSource(viewController: self)
    }

    @available (*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = data
        tableView.delegate = data
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.alwaysBounceVertical = true
        tableView.keyboardDismissMode = .interactive

        if useRefreshControl {
            let control = UIRefreshControl()
            control.addTarget(self, action: #selector(refreshTriggered), for: .valueChanged)
            control.tintColor = refreshControlTintColor
            refreshControl = control
        }

        configureTableView?(tableView)

        notificationObject = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: BrandingManager.didChange), object: nil, queue: nil) { [weak self] (_) in
            guard let `self` = self else { return }
            guard self.tearDownOnBrandChange else { return }
            self.tearDownSections()
        }
    }

    deinit {
        if let observer = notificationObject {
            NotificationCenter.default.removeObserver(observer)
        }
    }

    @objc open func refreshTriggered() {
        didPullDownToRefreshClosure?()
    }

    private func tearDownSections() {
        let indexPath = tableView.indexPathForRow(at: CGPoint(x: tableView.bounds.size.width/2, y: tableView.bounds.size.height/2))
        dataSource.tearDownCellSubviews()
        reload()
        guard let ip = indexPath else { return }
        tableView.scrollToRow(at: ip, at: .middle, animated: false)
    }

    // MARK: - Accessors

    open var refreshControlTintColor: UIColor {
        return .atom(.refreshControl)
    }

    public var didScrollClosure: ((UIScrollView) -> Void)? {
        get { return data.didScroll }
        set { data.didScroll = newValue }
    }
}
