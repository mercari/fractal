//
//  CarouselView.swift
//  DesignSystem
//
//  Created by anthony on 26/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//
import Foundation
import UIKit

public class CarouselViewController: UICollectionViewController {

    public init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.sectionInset = .zero
        flowLayout.headerReferenceSize = .zero
        super.init(collectionViewLayout: flowLayout)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
