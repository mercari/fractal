//
//  MyPageProfileViewController.swift
//  Home
//
//  Created by anthony on 22/02/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation

private extension MyPageProfileViewController {
    class ViewModel {
        var loggedInUser: Bool = false
    }
}

public class MyPageProfileViewController: UIViewController {

    private let viewModel = ViewModel()

    private static let profileImageSize: CGFloat = 64.0
    public static let imageOverhang: CGFloat = 10.0
    public static let height: CGFloat = 92.0

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(contentView)
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(profileButton)
        view.addSubview(starRatingView)

        let imageSize = MyPageProfileViewController.profileImageSize

        contentView.setContentCompressionResistancePriority(.required, for: .vertical)
        contentView.pin(to: view, [.leading,
                                   .bottom,
                                   .trailing,
                                   .top(MyPageProfileViewController.imageOverhang)])

        imageView.pin(to: view, [.leading(.keyline),
                                 .top,
                                 .width(asConstant: imageSize),
                                 .height(asConstant: imageSize)])

        profileButton.pin(to: view, [.trailing(-.keyline),
                                     .bottom(-.xsmall)])

        nameLabel.pin(to: [view: [.trailing(-.keyline)],
                           contentView: [.top(.default)],
                           imageView: [.rightOf(.keyline)]])

        starRatingView.pin(to: [imageView: [.leading, .below(.xsmall)],
                                view: [.bottom(-.xsmall)]
                                ])
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loggedInUser = !viewModel.loggedInUser
        reload()
    }

    @objc private func profileTapped() {
        let vc = UIViewController()
        vc.view.backgroundColor = .background()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    public func reload() {
        if viewModel.loggedInUser {
            nameLabel.text = "Mr A. User"
            profileButton.alpha = 1.0
        } else {
            nameLabel.text = "No User"
            profileButton.alpha = 0.0
        }
    }

    // MARK: - Properties

    private var nameLabel: Label = {
        let label = Label()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.apply(typography: .xlargeStrong)
        label.numberOfLines = 0
        return label
    }()

    private var starRatingView: StarRatingView = {
        let view = StarRatingView()
        return view
    }()

    private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .background(.cell)
        return view
    }()

    private lazy var officialImageView: ImageView = {
        let imageView = ImageView(design: .official)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = MyPageProfileViewController.profileImageSize/2
        imageView.layer.borderWidth = 4.0
        imageView.layer.borderColor = self.contentView.backgroundColor?.cgColor
        return imageView
    }()

    private lazy var imageView: ImageView = {
        let imageView = ImageView(design: .profilePlaceholder)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = MyPageProfileViewController.profileImageSize/2
        imageView.layer.borderWidth = 4.0
        imageView.layer.borderColor = self.contentView.backgroundColor?.cgColor
        return imageView
    }()

    private var profileButton: Button = {
        let button = Button(style: .textLink(size: Button.Style.Size(width: .natural, height: .natural)))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Profile", for: .normal)
        button.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
        return button
    }()
}
