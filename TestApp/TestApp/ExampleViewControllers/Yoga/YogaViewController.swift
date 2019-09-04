//
//  YogaViewController.swift
//  TestApp
//
//  Created by anthony on 26/08/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

class YogaViewController: SectionTableViewController, SectionBuilder {

    var presenter: MockYogaPresenter!

    override func viewDidLoad() {
        title = "Yoga"
        super.viewDidLoad()
        view.backgroundColor = .background
        DependencyRegistry.shared.prepare(viewController: self)
    }

    func inject(_ presenter: MockYogaPresenter) {
        self.presenter = presenter
        setSections()
        reload()
    }
    
    private func setSections() {
        dataSource.sections = [
            spacing(30.0),
            buttonCarousel(with: self.presenter.yogaTypes, selectionClosure: { (index) in
                print("Button Selected at Index:", index)
            }),
            spacing(),
            headline("Popular Lessons"),
            yogaEventsCarousel(with: self.presenter.popularEvents,
                               selectionClosure: presenter.eventSelected),
            headline("New Lessons"),
            yogaEventsCarousel(with: self.presenter.newEvents,
                               selectionClosure: presenter.eventSelected),
            spacing(60.0),
            singleButton("Try Premium", tappedClosure: {
                print("Premium Selected")
            })
        ]
    }
}
