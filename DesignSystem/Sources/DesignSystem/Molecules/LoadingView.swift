//
//  LoadingView.swift
//  DesignSystem
//
//  Created by anthony on 13/03/2019.
//  Copyright © 2019 mercari. All rights reserved.
//

import Foundation
import UIKit

public class LoadingView: UIView {

    public enum Style: String {
        case white
        case gray

        var activityIndicatorViewStyle: UIActivityIndicatorView.Style {
            switch self {
            case .white:
                return .white
            case .gray:
                return .gray
            }
        }
    }

    private let style: Style

    public init(style: Style) {
        self.style = style
        super.init(frame: .zero)

        addSubview(activityIndicatorView)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(loading: Bool) {
        loading ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
    }

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .gray)
        activityIndicatorView.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleRightMargin, .flexibleLeftMargin]
        activityIndicatorView.center = self.center
        return activityIndicatorView
    }()
}
