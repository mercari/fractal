//
//  CommentView.swift
//  TestApp
//
//  Created by Anthony Smith on 05/09/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

public protocol CommentViewData {
    var name: String { get }
    var image: UIImage? { get }
    var dateString: String { get }
    var comment: String { get }
}

class CommentView: UIView {
    
    init() {
        super.init(frame: .zero)
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(dateLabel)
        addSubview(commentLabel)

        imageView.pin(to: self, [.leading(.keyline), .top(.small), .width(asConstant: CGSize.largeIcon.width), .height(asConstant: CGSize.largeIcon.height)])
        nameLabel.pin(to: imageView, [.rightOf(.keyline), .top])
        nameLabel.pin(to: self, [.trailing(-.keyline)])
        dateLabel.pin(to: nameLabel, [.leading, .below(.small), .trailing])
        commentLabel.pin(to: dateLabel, [.leading, .below(.small), .trailing])
        commentLabel.pin(to: self, [.bottom(-.large)])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(data: CommentViewData) {
        imageView.image = data.image
        nameLabel.text = data.name
        dateLabel.text = data.dateString
        commentLabel.text = data.comment
    }
    
    // MARK: - Properties
    
    private var imageView: ImageView = {
        let imageView = ImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4.0
        return imageView
    }()
    
    private lazy var nameLabel: Label = {
        let label = Label()
        label.apply(typography: .large(.strong), color: .text)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateLabel: Label = {
        let label = Label()
        label.apply(typography: .medium, color: .text(.detail))
        label.numberOfLines = 0
        return label
    }()

    private lazy var commentLabel: Label = {
        let label = Label()
        label.apply(typography: .medium, color: .text(.detail))
        label.numberOfLines = 0
        return label
    }()
}
