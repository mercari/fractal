//
//  ComponentCollectionViewController.swift
//  SectionSystem
//
//  Created by Anthony Smith on 09/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit

extension SectionCollectionViewController: SectionController {

    public var dataSource: SectionControllerDataSource { return data }

    public var didPullDownToRefreshClosure: (() -> Void)? {
        get { return refresh }
        set { refresh = newValue }
    }

    open func reloadSections(at indexes: [Int]) {

        if data.newSections {
            data.registerCells(in: collectionView, with: &registeredReuseIdentifiers)
        }

        if indexes.count > 0 {
            for index in indexes { data.sections[index].willReload() }
        } else {
            for section in data.sections { section.willReload() }
        }

        DispatchQueue.main.async {

            if indexes.count > 0 {
                UIView.performWithoutAnimation { self.collectionView.reloadSections(IndexSet(indexes)) }
                return
            }

            guard self.useRefreshControl else { self.collectionView.reloadData(); self.collectionView.layoutIfNeeded(); return }

            if self.refreshControl.isRefreshing {
                self.refreshControl.perform(#selector(self.refreshControl.endRefreshing), with: nil, afterDelay: 0.5, inModes: [RunLoop.Mode.common])
                self.collectionView.perform(#selector(self.collectionView.reloadData), with: nil, afterDelay: 0.8, inModes: [RunLoop.Mode.common])
            } else {
                self.collectionView.reloadData()
            }
        }
    }
}

public class SectionCollectionViewController: UICollectionViewController {

    private let useRefreshControl: Bool
    private var data: SectionControllerDataSource!
    private var registeredReuseIdentifiers: Set<String> = [defaultReuseIdentifier]
    fileprivate var refresh: (() -> Void)?
    public init(useRefreshControl: Bool = false, layout: UICollectionViewLayout? = nil) {
        self.useRefreshControl = useRefreshControl
        super.init(collectionViewLayout: layout ?? SectionCollectionViewController.defaultFlowLayout())
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
            collectionView.alwaysBounceVertical = true
            if #available(iOS 10.0, *) {
                collectionView.refreshControl = refreshControl
            } else {
                collectionView.addSubview(refreshControl)
            }
        }
        collectionView.backgroundColor = .clear
        collectionView.dataSource = data
        collectionView.delegate = data
        collectionView.keyboardDismissMode = .interactive
    }

    @available (*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc open func refreshTriggered() {
        refresh?()
    }

    // MARK: - Accessors

    open var refreshControlTintColor: UIColor {
        return .atom(.refreshControl)
    }

    // MARK: - Properties

    private static func defaultFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.sectionInset = .zero
        flowLayout.headerReferenceSize = .zero
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        return flowLayout
    }

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTriggered), for: .valueChanged)
        refreshControl.tintColor = self.refreshControlTintColor
        return refreshControl
    }()
}
