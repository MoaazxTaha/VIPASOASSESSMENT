//
//  StatefulView.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation
import SFSafeSymbols
import UIKit

class StatefulView: UIView {

    // MARK: - Interface

    func config(imageSource: ImageSource, message: String) {
        image.apply(imageSource)
        title.text = message
        setupConstraints()
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views

    private lazy var image: UIImageView = UIImageView().with {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = Colors.primaryGray.color
    }

    private lazy var title: UILabel = UILabel().with {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.apply(.init(font: .headLineS, color: Colors.primaryGray.color))
    }

    private var stackView: UIStackView = UIStackView().with {
        $0.axis = .vertical
        $0.spacing = Style.padding.double
    }

    // MARK: - Setup

    private func setupViews() {
        stackView.addArrangedSubViews(image, title)
        addSubview(stackView)
        backgroundColor = .systemBackground
        isUserInteractionEnabled = false
    }

    private func setupConstraints() {
        stackView.withConstraints {
            $0.alignCenter()
            + [
                $0.alignLeading(constant: Style.padding.double),
                $0.alignTrailing(constant: -Style.padding.double)
            ]
        }
    }
}

// MARK: - generic Views

extension StatefulView {
    static func emptyView() -> StatefulView {
        StatefulView().with {
            $0.config(
                imageSource: .asset(.init(systemSymbol: .xmarkBinCircle)),
                message: Strings.emptyViewMessage
            )
        }
    }

    static func genericError() -> StatefulView {
        StatefulView().with {
            $0.config(
                imageSource: .asset(.init(systemSymbol: .xmarkCircle)),
                message: Strings.genericErrorMessage
            )
        }
    }

    static func noNetwork() -> StatefulView {
        StatefulView().with {
            $0.config(
                imageSource: .asset(UIImage(systemSymbol: .wifiSlash)),
                message: Strings.networkErrorConnectionFailure
            )
        }
    }
}
