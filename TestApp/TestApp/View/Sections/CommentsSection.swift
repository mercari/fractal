//
//  CommentsSection.swift
//  TestApp
//
//  Created by Anthony Smith on 05/09/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

extension SectionBuilder {
    public func comments(with data: @autoclosure @escaping () -> [CommentViewData]) -> CommentsSection {
        return CommentsSection().enumerate(data) as! CommentsSection
    }
}

extension CommentsSection: EnumeratableSection {
    public typealias DataType = CommentViewData
}

public class CommentsSection {

}

extension CommentsSection: ViewSection {
    
    public func createView() -> UIView {
        return CommentView()
    }
    
    public func size(in view: UIView, at index: Int) -> SectionCellSize {
        return SectionCellSize(width: view.bounds.size.width, height: nil)
    }
    
    public func configure(_ view: UIView, at index: Int) {
        (view as? CommentView)?.set(data: data[index])
    }
}
