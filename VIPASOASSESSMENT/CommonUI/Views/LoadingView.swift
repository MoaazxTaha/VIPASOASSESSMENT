//
//  LoadingView.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation
import UIKit

class LoadingView: UIView {
    // MARK: - Views

    private lazy var activityIndicator = UIActivityIndicatorView().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .white
    }

    private var bufferView = UIView().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Colors.primaryGray.color.withAlphaComponent(0.1)
        $0.layer.cornerRadius = Style.padding.single
    }

    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        startLoading()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - setup

    func setupViews() {
        bufferView.addSubview(activityIndicator)
        addSubview(bufferView)
        backgroundColor = .systemBackground
    }

    func setupConstraints() {
        bufferView.withConstraints {
            $0.alignCenter()
        }

        activityIndicator.withConstraints {
            $0.alignEdges(insets: Style.EdgeInset.double)
        }
    }
    
    // MARK: - helper

    func startLoading() {
        activityIndicator.startAnimating()
        bufferView.isHidden = false
    }

    func endLoading() {
        activityIndicator.stopAnimating()
        bufferView.isHidden = true
    }
}
