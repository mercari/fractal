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

        data.notifySectionsOfReload(in: indexes)

        DispatchQueue.main.async {

            guard self.useRefreshControl else {

                if indexes.count > 0 {
                    UIView.performWithoutAnimation { self.collectionView.reloadSections(IndexSet(indexes)) }
                } else {
                    self.collectionView.reloadData()
                    self.collectionView.layoutIfNeeded()
                }

                return
            }

            if self.collectionView.refreshControl?.isRefreshing ?? false {
                self.perform(#selector(self.reloadRefresh), with: nil, afterDelay: 0.4, inModes: [RunLoop.Mode.common])
            } else {

                if indexes.count > 0 {
                    UIView.performWithoutAnimation { self.collectionView.reloadSections(IndexSet(indexes)) }
                } else {
                    self.collectionView.reloadData()
                    self.collectionView.layoutIfNeeded()
                }
            }
        }
    }

    @objc private func reloadRefresh() {
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        collectionView.refreshControl?.perform(#selector(collectionView.refreshControl?.endRefreshing), with: nil, afterDelay: 0.2, inModes: [RunLoop.Mode.common])
    }
}

open class SectionCollectionViewController: UICollectionViewController {

    private let useRefreshControl: Bool
    private var data: SectionControllerDataSource!
    private var registeredReuseIdentifiers: Set<String> = []
    private var notificationObject: NSObjectProtocol?
    fileprivate var refresh: (() -> Void)?
    public var tearDownOnBrandChange: Bool = true

    public init(useRefreshControl: Bool = false, layout: UICollectionViewLayout? = nil, direction: UICollectionView.ScrollDirection = .vertical) {
        self.useRefreshControl = useRefreshControl
        super.init(collectionViewLayout: layout ?? SectionCollectionViewController.defaultFlowLayout(direction))
        data = SectionControllerDataSource(viewController: self)
    }

    public var didScrollClosure: ((UIScrollView) -> Void)? {
        get { return data.didScroll }
        set { data.didScroll = newValue }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        collectionView.backgroundColor = .clear
        collectionView.dataSource = data
        collectionView.delegate = data
        collectionView.keyboardDismissMode = .interactive

        if useRefreshControl {
            testLargeTitleSanity()
            collectionView.alwaysBounceVertical = true
            if #available(iOS 10.0, *) {
                collectionView.refreshControl = refreshControl
            } else {
                collectionView.addSubview(refreshControl)
            }
        }
        
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

    @available (*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc open func refreshTriggered() {
        refresh?()
    }

    private func tearDownSections() {
        let indexPath = collectionView.indexPathForItem(at: CGPoint(x: collectionView.bounds.size.width/2, y: collectionView.bounds.size.height/2))
        dataSource.tearDownCellSubviews()
        reload()
        guard let ip = indexPath else { return }
        collectionView.scrollToItem(at: ip, at: .centeredHorizontally, animated: false)
    }

    private func testLargeTitleSanity() {
        if let nc = navigationController {
            if (nc.navigationBar.prefersLargeTitles && navigationItem.largeTitleDisplayMode != .never) ||
                navigationItem.largeTitleDisplayMode == .always {
                print("*** Fractal Warning: estimatedItemSize does not work with prefersLargeTitles / largeTitleDisplayMode ***")
                (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = .zero
            }
        } else {
            print("*** Fractal Warning: No navigation controller set, could not assert using large titles or not ***")
        }
    }

    // MARK: - Accessors

    open var refreshControlTintColor: UIColor {
        return .atom(.refreshControl)
    }

    // MARK: - Properties
    
    private static func defaultFlowLayout(_ direction: UICollectionView.ScrollDirection) -> UICollectionViewFlowLayout {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = direction
//        flowLayout.minimumInteritemSpacing = 0.0
//        flowLayout.minimumLineSpacing = 0.0
//        flowLayout.sectionInset = .zero
//        flowLayout.headerReferenceSize = .zero
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
