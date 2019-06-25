//
//  SectionViewController+InputChain.swift
//  SectionSystem
//
//  Created by anthony on 13/05/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation

public protocol InputChain {
    var inputResponders: [UIResponder] { get }
    func triggerNext(after responder: UIResponder?) -> Bool
}

extension UIResponder {
    public func notifyNextInput() {
        UIApplication.shared.sendAction(#selector(UIViewController.notifyNextInputResponder), to: nil, from: self, for: nil)
    }
}

extension Section {
    public func requestLayout() {
        UIApplication.shared.sendAction(#selector(UIViewController.layoutSection), to: nil, from: self, for: nil)
    }
}

extension SectionControllerDataSource {

    // A little naive with respect to traversing NestedSections
    fileprivate func nextResponder(after sender: Any, at indexPath: IndexPath, checkClosure: @escaping (IndexPath) -> Bool) {

        guard indexPath.section < sections.count else { return }

        for s in indexPath.section..<sections.count {
            let section = sections[s]
            let startingIndex = s == indexPath.section ? indexPath.item : 0
            if section.hasInputs { // sanity
                for i in startingIndex..<section.itemCount {
                    if checkClosure(IndexPath(item: i, section: s)) { return }
                }
            }
        }
    }
}

extension SectionCollectionViewController {

    @objc override func notifyNextInputResponder(_ sender: Any) {
        guard let previousResponder = sender as? UIResponder else { Assert("notifyNextInputResponder sender wasn't a UIResponder"); return }

        var sectionStartingIndex = 0
        var itemStartingIndex = 0

        if let cell = (previousResponder as? UIView)?.findInHierarchy(SectionCollectionViewCell.self) {
            let indexPath = collectionView.indexPath(for: cell)
            sectionStartingIndex = indexPath?.section ?? 0
            itemStartingIndex = indexPath?.item ?? 0
        }

        dataSource.nextResponder(after: sender, at: IndexPath(item: itemStartingIndex, section: sectionStartingIndex)) { [weak self] (indexPath) in
            guard let `self` = self else { return false }
            guard let cell = self.collectionView.cellForItem(at: indexPath) as? SectionCollectionViewCell else { return false }
            let chain = cell.sectionView as? InputChain ?? cell.sectionViewController as? InputChain
            return chain?.triggerNext(after: previousResponder) ?? false
        }
    }

    @objc override func layoutSection(_ sender: Any) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension SectionTableViewController {

    @objc override func notifyNextInputResponder(_ sender: Any) {
        guard let previousResponder = sender as? UIResponder else { Assert("notifyNextInputResponder sender wasn't a UIResponder"); return }

        var sectionStartingIndex = 0
        var itemStartingIndex = 0

        if let cell = (previousResponder as? UIView)?.findInHierarchy(SectionTableViewCell.self) {
            let indexPath = tableView.indexPath(for: cell)
            sectionStartingIndex = indexPath?.section ?? 0
            itemStartingIndex = indexPath?.item ?? 0
        }

        dataSource.nextResponder(after: sender, at: IndexPath(item: itemStartingIndex, section: sectionStartingIndex)) { [weak self] (indexPath) in
            guard let `self` = self else { return false }
            guard let cell = self.tableView.cellForRow(at: indexPath) as? SectionTableViewCell else { return false }
            let chain = cell.sectionView as? InputChain ?? cell.sectionViewController as? InputChain
            return chain?.triggerNext(after: previousResponder) ?? false
        }
    }

    @objc override func layoutSection(_ sender: Any) {

        var cell: SectionTableViewCell?

        if let section = sender as? ViewSection {
            cell = section.visibleView?.findInHierarchy(SectionTableViewCell.self)
        } else if let section = sender as? ViewControllerSection {
            cell = section.visibleViewController?.view.findInHierarchy(SectionTableViewCell.self)
        } else {
            Assert("layoutSection: sender is not a BedrockSection")
        }

        UIView.performWithoutAnimation {
            tableView.beginUpdates()
            tableView.endUpdates()
        }

        if let cell = cell, let indexPath = tableView.indexPath(for: cell) {
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
}

extension UIViewController {
    @objc func notifyNextInputResponder(_ sender: Any) {
        Assert("ViewController does not respond to notifyNextInputResponder")
    }

    @objc func layoutSection(_ sender: Any) {
        Assert("ViewController does not respond to layoutSection")
    }
}
