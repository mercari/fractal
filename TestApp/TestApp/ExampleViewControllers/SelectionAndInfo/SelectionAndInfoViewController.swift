//
//  SelectionAndInfoViewController.swift
//  DesignSystemApp
//
//  Created by anthony on 03/04/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import DesignSystem

class SelectionAndInfoViewController: UIViewController, SectionBuilder {

    private var sectionViewController: SectionController!
    private let viewModel = ViewModel()
    private var switch1Value = Observable<Bool>(true)
    private var switch2Value = Observable<Bool>(true)
    private var switch3Value = Observable<Bool>(true)
    private var switch4Value = Observable<Bool>(true)

    private var didChange: () -> Void {
        return { [weak self] in
            guard let `self` = self else { return }
            self.sectionViewController.reload()
        }
    }

    override func viewDidLoad() {
        title = "SelectionAndInfoVC"
        super.viewDidLoad()
        view.backgroundColor = .background
        DependencyRegistry.shared.prepare(viewController: self)
        setSections()
        didChange()
    }

    func inject(sectionController: SectionViewController) {
        self.sectionViewController = sectionController
        self.contain(sectionController)
    }

    private func setSections() {
        sectionViewController.dataSource.sections = [
            group([
                information("Information", detailClosure: { () -> String in return "Detail" })
                ]),
            seperator(),
            group([
                switchOption("Switch Option", observedBool: switch1Value),
                switchOption("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
                             observedBool: switch2Value),
                switchOption("Detail Switch", detail: "Detail", observedBool: switch3Value),
                switchOption("Detail Switch", detail: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua", observedBool: switch4Value)
                ]),
            seperator(),
            group([checkboxOptions(viewModel.checkboxDataClosure, selectionClosure: checkboxSelectedClosure)]),
            seperator(),
            group([checkboxOptions(viewModel.detailCheckboxDataClosure, style: .detail, selectionClosure: checkboxSelectedClosure)]),
            spacing()
        ]
    }

    fileprivate var checkboxSelectedClosure: (Int, CheckboxOption) -> Void {
        let closure: (Int, CheckboxOption) -> Void = { (index, option) in
            self.viewModel.selectedIndex = index
        }
        return closure
    }

    fileprivate var detailCheckboxDataClosure: (Int, CheckboxOption) -> Void {
        let closure: (Int, CheckboxOption) -> Void = { (index, option) in
            self.viewModel.detailSelectedIndex = index
        }
        return closure
    }
}

fileprivate struct DemoOption {
    let value1: String
    let detailValue: String?
}

extension DemoOption: CheckboxOption {
    var id: String {
        return value1
    }
    var title: String {
        return value1
    }
    var detail: String? {
        return detailValue
    }
}

extension SelectionAndInfoViewController {

    fileprivate class ViewModel {

        fileprivate var switch1Value: Bool = true
        fileprivate var switch2Value: Bool = true
        fileprivate var switch3Value: Bool = true
        fileprivate var switch4Value: Bool = true
        fileprivate var selectedIndex: Int = -1
        fileprivate var detailSelectedIndex: Int = -1

        fileprivate var checkboxDataClosure: () -> (Int, [CheckboxOption]) {
            let closure: () -> (Int, [CheckboxOption]) = {
                var array = [CheckboxOption]()
                for i in 0..<4 {
                    array.append(DemoOption(value1: "Option \(i+1)", detailValue: nil))
                }
                return (self.selectedIndex, array)
            }
            return closure
        }

        fileprivate var detailCheckboxDataClosure: () -> (Int, [CheckboxOption]) {
            let closure: () -> (Int, [CheckboxOption]) = {

                let option1 = DemoOption(value1: "Detail Option 1", detailValue: "Lorem ipsum")
                let option2 = DemoOption(value1: "Detail Option 2", detailValue: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt")
                let option3 = DemoOption(value1: "Detail Option 3 with a super long title so we can test more than one line of text wraps correctly", detailValue: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")

                return (self.detailSelectedIndex, [option1, option2, option3])
            }
            return closure
        }
    }
}
