//
//  CarouselViewController.swift
//  DesignSystem
//
//  Created by anthony on 26/11/2018.
//  Copyright © 2018 mercari. All rights reserved.
//
import Foundation
import DesignSystem

public class CarouselViewController: SectionCollectionViewController {

    public init() {
        super.init(useRefreshControl: false, direction: .horizontal)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
}
