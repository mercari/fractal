//
//  SizeOptionsViewModel.swift
//  DesignSystemApp
//
//  Created by anthony on 17/01/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import DesignSystem

public protocol SizeOption {
    var name: String { get }
    var size: CGSize { get }
}

extension SectionBuilder {
    func sizeOptions(_ options: [SizeOption]) -> SizeOptionsSection {
        return SizeOptionsSection(options: options)
    }
}

class SizeOptionsSection {
    let options: [SizeOption]

    init(options: [SizeOption]) {
        self.options = options
    }
}

extension SizeOptionsSection: ViewSection {

    public func createView() -> UIView {
        return SizeOptionView()
    }

    func size(in view: UIView, at index: Int) -> SectionCellSize {
        let option = self.options[index]
        let height = option.name.height(typography: .small, width: view.bounds.size.width - .keyline*2)
        return SectionCellSize(width: view.bounds.size.width, height: max(height, option.size.height) + .small*2)
    }
    
    public var itemCount: Int {
        return self.options.count
    }

    public func configure(_ view: UIView, at index: Int) {
        let option = self.options[index]
        (view as? SizeOptionView)?.set(name: option.name, size: option.size)
    }
}
