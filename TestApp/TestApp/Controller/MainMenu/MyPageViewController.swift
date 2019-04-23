//
//  MyPageViewController.swift
//  DesignSystemApp
//
//  Created by anthony on 09/04/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import UIKit

import DesignSystem

extension MyPageMenuOption: NavigationOption {
    var detail: String? { return nil }
}

class MyPageViewController: UIViewController, SectionBuilder {

    private let viewModel = ViewModel()

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background()
        view.addSubview(headerBackgroundImageView)
        headerBackgroundImageView.applyConstraints()
        self.contain(sectionViewController)
        setSections()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func setSections() {

        let inquiryTitle = "Inquiry"
        let otherTitle = "Other"
        let clearCacheTitle = "Clear Cache"
        let versionTitle = "Version"

        sectionViewController.dataSource.sections = [spacing(ViewModel.headerViewHeight - MyPageProfileViewController.imageOverhang),
            profileHeader(),
            divider(),
            spacing(),
            group([navigationOptions(viewModel.menuOptions, selectionClosure: selectionClosure)]),
            navigationGroup(inquiryTitle, options: viewModel.menuOptions, selectionClosure: selectionClosure),
            navigationGroup(otherTitle, options: viewModel.menuOptions, selectionClosure: selectionClosure),
            spacing(),
            group([navigationOptions(viewModel.menuOptions, selectionClosure: selectionClosure)]),
            spacing(),
            group([information(versionTitle, detailClosure: viewModel.versionString)]),
            spacing(),
            singleButton(clearCacheTitle, style: .textLink, tappedClosure: deleteCacheTapped),
            spacing(),
            group([navigationOptions(viewModel.menuOptions, selectionClosure: selectionClosure)]),
            spacing()
        ]
        sectionViewController.reload()
    }

    // MARK: - Properties

    lazy var headerBackgroundImageView: BounceScaleImageView = {

        let imageView = BounceScaleImageView(imageHeight: ViewModel.headerViewHeight, scaleThreshold: 0.0, withBlur: false)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.with(design: .profileHeader)

        return imageView
    }()

    private lazy var sectionViewController: SectionViewController = {
        let viewController = SectionTableViewController()
        viewController.didScrollClosure = { [weak self] (scrollView) in
            self?.headerBackgroundImageView.set(for: scrollView.contentOffset.y)
        }
        return viewController
    }()

    private var selectionClosure: (Int, NavigationOption) -> Void {
        let closure: (Int, NavigationOption) -> Void = { (_, option) in
            guard let intent = option.intent else { Assert("No intent for option \(option.title)"); return }
            NavigationRouter.shared.perform(intent)
        }
        return closure
    }

    private var deleteCacheTapped: () -> Void {
        let closure = { print("Delete Cache") }
        return closure
    }
}

