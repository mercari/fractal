//
//  CarouselViewModel.swift
//  SectionSystem
//
//  Created by anthony on 26/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import DesignSystem

extension SectionBuilder {
    public func carousel(_ reuseIdentifier: String = UUID().uuidString, sections: [Section], height: CGFloat = 100.0, pagingEnabled: Bool = false) -> CarouselSection {
        return CarouselSection(id: reuseIdentifier, sections: sections, height: height, pagingEnabled: pagingEnabled)
    }
}

public class CarouselSection {

    private let id: String
    private let sections: [Section]
    private let height: CGFloat
    private let pagingEnabled: Bool
    private var registeredReuseIdentifiers: Set<String> = [defaultReuseIdentifier]

    fileprivate init(id: String, sections: [Section], height: CGFloat, pagingEnabled: Bool) {
        self.sections = sections
        self.id = id
        self.height = height
        self.pagingEnabled = pagingEnabled
    }
}

extension CarouselSection: ViewControllerSection {

    // We could reuse here... not 100% sure how yet other than
    // A: let developers override the carousel id / manually handle (current option)
    // B: or by the type of cells it holds (potentially messy as might need other properties to be captured)
    // C: Let all reload and eventually capture all the reuseIdentifiers they need (any value?)

    // TODO: Datasource potentially needs the id not the ViewModel

    public var reuseIdentifier: String {
        return "Carousel_\(id)"
    }

    public func createViewController() -> UIViewController {
        return CarouselViewController()
    }

    public func size(in view: UIView, at index: Int) -> SectionCellSize {
        return SectionCellSize(width: view.bounds.size.width, height: self.height)
    }

    public func configure(_ viewController: UIViewController, at index: Int) {

        guard let vc = viewController as? CarouselViewController else { return }
        vc.collectionView.isPagingEnabled = self.pagingEnabled
        vc.dataSource.sections = sections
        
        // move offset logic into other versions too
        // vc.collectionView.setContentOffset(CGPoint(x: vc.collectionView.contentSize.width > self.dataSource.offset ? self.dataSource.offset : 0.0, y: 0.0), animated: false)
        
        vc.reload()


    }
}
