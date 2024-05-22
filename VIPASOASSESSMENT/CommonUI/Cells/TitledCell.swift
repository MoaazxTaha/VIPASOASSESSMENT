//
//  TitledCell.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import UIKit

class TitledCell: UITableViewCell {
    // MARK: - InterFace

    public func configure(with viewModel: UserInfo) {
        titleLabel.text = viewModel.userName
        smallImageView.config(imageSource: .url(viewModel.avatarUrl))
    }

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views

    private lazy var titleLabel = UILabel().with {
        $0.numberOfLines = 0
        $0.apply(Style.text.headLineM)
        $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var smallImageView = AsyncLoadingImage().with {
        $0.setContentHuggingPriority(.required, for: .vertical)
        $0.addBorder()
        $0.applyCornerCurve()
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Setup
    
    private func setupConstraints() {
        contentView.addSubview(smallImageView)
        smallImageView.translatesAutoresizingMaskIntoConstraints = false
        smallImageView.withConstraints {
            [
                $0.alignTop(constant: Style.padding.single),
                $0.alignLeading(constant: Style.padding.single),
                $0.alignBottom(constant: -Style.padding.single),
                $0.constraintWidth(ImageSource.Size.smallDimenssion)
//                $0.constraintHeight(ImageSource.Size.smallDimenssion)
            ]
        }

        contentView.addSubview(titleLabel)
        titleLabel.withConstraints {
            [
                $0.alignTop(constant: Style.padding.single),
                $0.alignBottom(constant: -Style.padding.single),
                $0.leadingAnchor.constraint(equalTo: smallImageView.trailingAnchor, constant: Style.padding.single),
                $0.alignTrailing(constant: Style.padding.single),
            ]
        }
    }
}
