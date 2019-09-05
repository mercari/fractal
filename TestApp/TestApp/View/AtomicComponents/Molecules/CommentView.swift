//
//  CommentView.swift
//  TestApp
//
//  Created by Anthony Smith on 05/09/2019.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import DesignSystem

protocol CommentViewData {
    var _name: String { get }
    var _image: UIImage? { get }
    var _dateString: String { get }
    var _comment: String { get }
}

class CommentView: UIView {
    
    init() {
        super.init(frame: .zero)
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(dateLabel)
        addSubview(commentLabel)

        imageView.pin(to: self, [.leading(.keyline), .top(.small)])
        nameLabel.pin(to: self, [.trailing(-.keyline)])
        nameLabel.pin(to: imageView, [.rightOf(.small), .top])
        dateLabel.pin(to: nameLabel, [.leading, .below(.small), .trailing])
        commentLabel.pin(to: imageView, [.leading, .below(.small), .trailing])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(data: CommentViewData) {
        imageView.image = data._image
        nameLabel.text = data._name
        dateLabel.text = data._dateString
        commentLabel.text = data._comment
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
