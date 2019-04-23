//
//  SectionControllerDataSource.swift
//  SectionSystem
//
//  Created by anthony on 21/12/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation

open class SectionControllerDataSource: NSObject {

    public var sections: [Section] = [] { didSet { newSections = true } }
    private(set) var newSections: Bool = false
    public var offset: CGFloat = 0.0 // TODO: Look at changing sections, potentially find current cell and keep hold of it, creating non moving section reloading if needed
    private let viewController: UIViewController
    var didScroll: ((UIScrollView) -> Void)?
    
    public init(viewController: UIViewController) {
        self.viewController = viewController
        super.init()
    }

    func registerCells(in collectionView: UICollectionView, with registeredReuseIdentifiers: inout Set<String>) {
        for section in sections {
            if let nestedSection = section as? NestedSection {
                for id in nestedSection.reuseIdentifiers {
                    guard !registeredReuseIdentifiers.contains(id) else { continue }
                    registeredReuseIdentifiers.insert(id)
                    collectionView.register(SectionCollectionViewCell.self, forCellWithReuseIdentifier: id)
                }
            } else if let bedrockSection = section as? BedrockSection {
                let id = bedrockSection.reuseIdentifier
                guard !registeredReuseIdentifiers.contains(id) else { continue }
                registeredReuseIdentifiers.insert(id)
                collectionView.register(SectionCollectionViewCell.self, forCellWithReuseIdentifier: id)
            }
        }
        newSections = false
    }

    func registerCells(in tableView: UITableView, with registeredReuseIdentifiers: inout Set<String>) {
        for section in sections {
            if let nestedSection = section as? NestedSection {
                for id in nestedSection.reuseIdentifiers {
                    guard !registeredReuseIdentifiers.contains(id) else { continue }
                    registeredReuseIdentifiers.insert(id)
                    tableView.register(SectionTableViewCell.self, forCellReuseIdentifier: id)
                }
            } else if let bedrockSection = section as? BedrockSection {
                let id = bedrockSection.reuseIdentifier
                guard !registeredReuseIdentifiers.contains(id) else { continue }
                registeredReuseIdentifiers.insert(id)
                tableView.register(SectionTableViewCell.self, forCellReuseIdentifier: id)
            } else {
                Assert("Section in array \(String(describing: section)) not Nested or Bedrock type")
            }
        }
        newSections = false
    }

    fileprivate func bedrock(for indexPath: IndexPath) -> (BedrockSection, Int)? {

        func bedrock(in section: Section, index: Int) -> (BedrockSection, Int)? {

            if let nestedSection = section as? NestedSection {
                return bedrock(in: nestedSection.section(at: index), index: nestedSection.givenSectionIndex(from: index))
            } else if let bedrock = section as? BedrockSection {
                return (bedrock, index)
            }

            Assert("Section in array \(String(describing: section)) not Nested or Bedrock type")
            // This will not happen due to missing reuse... but just in case things change
            return nil
        }

        return bedrock(in: sections[indexPath.section], index: indexPath.item)
    }
}

extension SectionControllerDataSource: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        offset = scrollView.contentOffset.x
        didScroll?(scrollView)
    }
}

extension SectionControllerDataSource: UITableViewDataSource, UITableViewDelegate {

    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].itemCount
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let bedrock = bedrock(for: indexPath) else { return 10.0 }
        let section = bedrock.0
        let index = bedrock.1
        return section.height(in: tableView, at: index) ?? UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let bedrock = bedrock(for: indexPath) else {
            return defaultCell(at: indexPath, in: tableView)
        }

        let section = bedrock.0
        let index = bedrock.1

        guard let cell = tableView.dequeueReusableCell(withIdentifier: section.reuseIdentifier, for: indexPath) as? SectionTableViewCell else {
            print("TableView unable to dequeue cell for Section: \(String(describing: section)) ReuseId:\(section.reuseIdentifier)")
            return defaultCell(at: indexPath, in: tableView)
        }

        if let viewSection = section as? ViewSection {

            cell.section = viewSection

            guard let view = cell.sectionView else {

                let sectionView = viewSection.createView()
                sectionView.translatesAutoresizingMaskIntoConstraints = false
                cell.contentView.addSubview(sectionView)
                sectionView.pin(to: cell.contentView)
                cell.sectionView = sectionView

                viewSection.configure(sectionView, at: index)
                cell.contentView.setNeedsLayout()
                cell.contentView.layoutIfNeeded()
                return cell
            }

            viewSection.configure(view, at: index)

            return cell

        } else if let viewControllerSection = section as? ViewControllerSection {

            cell.section = viewControllerSection

            guard let vc = cell.sectionViewController else {

                let newVC = viewControllerSection.createViewController()

                viewController.contain(newVC) { (containerView) -> ([NSLayoutConstraint]) in
                    cell.contentView.addSubview(containerView)
                    return containerView.pin(to: cell.contentView)
                }

                cell.sectionViewController = newVC
                viewControllerSection.configure(newVC, at: index)
                cell.contentView.setNeedsLayout()
                cell.contentView.layoutIfNeeded()
                return cell
            }

            viewControllerSection.configure(vc, at: index)

            return cell
        }

        return cell
    }

    private func defaultCell(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        let defaultCell = tableView.dequeueReusableCell(withIdentifier: defaultReuseIdentifier, for: indexPath)
        defaultCell.backgroundColor = .red //TODO: use for debug only... maybe assert
        return defaultCell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SectionTableViewCell, let view = cell.sectionView else { return }
        guard let bedrock = bedrock(for: indexPath) else { return }
        let section = bedrock.0
        let index = bedrock.1
        section.didSelect(view, at: index)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SectionControllerDataSource: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].itemCount
    }

    @objc public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let bedrock = bedrock(for: indexPath) else { return CGSize(width: collectionView.bounds.size.width, height: 44.0) }
        let section = bedrock.0
        let index = bedrock.1
        let sectionSize = section.size(in: collectionView, at: index)
        let defaultSize = CGSize(width: collectionView.bounds.size.width, height: 44.0)

        return sectionSize ?? defaultSize
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let bedrock = bedrock(for: indexPath) else {
            return defaultCell(at: indexPath, in: collectionView)
        }

        let section = bedrock.0
        let index = bedrock.1

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: section.reuseIdentifier, for: indexPath) as? SectionCollectionViewCell else {
            print("CollectionView unable to dequeue cell for Section: \(String(describing: section)) ReuseId:\(section.reuseIdentifier)")
            return defaultCell(at: indexPath, in: collectionView)
        }

        if let viewSection = section as? ViewSection {

            cell.section = viewSection
            cell.indexPath = indexPath

            guard let view = cell.sectionView else {

                let sectionView = viewSection.createView()
                sectionView.translatesAutoresizingMaskIntoConstraints = false
                cell.contentView.addSubview(sectionView)
                sectionView.pin(to: cell.contentView)
                cell.sectionView = sectionView

                viewSection.configure(sectionView, at: index)
                cell.contentView.setNeedsLayout()
                cell.contentView.layoutIfNeeded()
                return cell
            }

            viewSection.configure(view, at: index)

            return cell

        } else if let viewControllerSection = section as? ViewControllerSection {

            cell.section = viewControllerSection

            guard let vc = cell.sectionViewController else {

                let newVC = viewControllerSection.createViewController()

                viewController.contain(newVC) { (containerView) -> ([NSLayoutConstraint]) in
                    cell.contentView.addSubview(containerView)
                    return containerView.pin(to: cell.contentView)
                }

                cell.sectionViewController = newVC
                viewControllerSection.configure(newVC, at: index)
                cell.contentView.setNeedsLayout()
                cell.contentView.layoutIfNeeded()
                return cell
            }

            viewControllerSection.configure(vc, at: index)

            return cell
        }

        return cell
    }

    private func defaultCell(at indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: defaultReuseIdentifier, for: indexPath)
        defaultCell.backgroundColor = .red //TODO: use for debug only... maybe assert
        return defaultCell
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SectionCollectionViewCell, let view = cell.sectionView else { return }
        guard let bedrock = bedrock(for: indexPath) else { return }
        let section = bedrock.0
        let index = bedrock.1
        section.didSelect(view, at: index)
        collectionView.deselectItem(at: indexPath, animated: true)
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sections[section].itemInsets
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sections[section].minimumLineSpacing
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sections[section].minimumInteritemSpacing
    }
}
