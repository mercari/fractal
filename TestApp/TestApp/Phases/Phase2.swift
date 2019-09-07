//
//  Phase2.swift
//  TestApp
//
//  Created by Anthony Smith on 07/09/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

//class DescriptionView: UIView {
//
//    init() {
//        super.init(frame: .zero)
//        addSubview(label)
//        label.pin(to: self, [.leading(.keyline), .top(.small), .trailing(-.keyline), .bottom])
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func set(text: String) {
//        label.text = text
//    }
//
//    // MARK: - Properties
//
//    private lazy var label: Label = {
//        let label = Label()
//        label.apply(typography: .medium, color: .text(.detail))
//        label.numberOfLines = 0
//        return label
//    }()
//}
//
//extension SectionBuilder {
//    public func description(_ textClosure: @autoclosure @escaping () -> String) -> DescriptionSection {
//        return DescriptionSection(textClosure)
//    }
//}
//
//public class DescriptionSection {
//
//    let closure: () -> String
//
//    public init(_ closure: @escaping () -> String) {
//        self.closure = closure
//    }
//}
//
//extension DescriptionSection: ViewSection {
//
//    public func createView() -> UIView {
//        return DescriptionView()
//    }
//
//    public func size(in view: UIView, at index: Int) -> SectionCellSize {
//        return SectionCellSize(width: view.bounds.size.width, height: nil)
//    }
//
//    public func configure(_ view: UIView, at index: Int) {
//        (view as? DescriptionView)?.set(text: closure())
//    }
//}

// Replace 200.0 spacing in YogaDetailViewController

// description(self.presenter.event.description),
