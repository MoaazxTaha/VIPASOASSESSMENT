//
//  AsyncLoadingImage.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation
import RxSwift
import UIKit

class AsyncLoadingImage: UIView {
    // MARK: - Image State

    enum State {
        case loading
        case loaded(UIImage)
        case empty
    }

    // MARK: - InTerface

    func config(imageSource: ImageSource) {
        imageStateSubject.onNext(.loading)

        switch imageSource {
        case .asset(let image):
            imageStateSubject.onNext(.loaded(image))
        case .url(let url):
            imageSource.downloadImage(fromURL: URL(string: url)) { [weak self] image in
                guard let self, let image
                else {
                    self?.imageStateSubject.onNext(.empty)
                    return
                }

                self.imageStateSubject.onNext(.loaded(image))
            }
        }
    }

    // MARK: - Private properties

    private let imageStateSubject = BehaviorSubject<State>(value: .loading)
    private let disposeBag = DisposeBag()

    // MARK: - Views

    lazy var imageView = UIImageView().with {
        $0.contentMode = .scaleAspectFit
        layer.allowsEdgeAntialiasing = true
    }

    lazy var loadingView = UIActivityIndicatorView().with {
        $0.tintColor = .white
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupBinding()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupViews() {
        backgroundColor = Colors.primaryGray.color.withAlphaComponent(0.1)
        addSubview(imageView)
        addSubview(loadingView)

        imageView.withConstraints {
            $0.alignEdges()
        }

        loadingView.withConstraints {
            $0.alignEdges()
        }
    }

    private func setupBinding() {
        imageStateSubject
            .subscribe(onNext: { [weak self] state in
                guard let self else { return }
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }

                    switch state {
                    case .empty:
                        self.imageView.isHidden = false
                        self.imageView.image = Images.emptyStateImage.image
                        self.loadingView.isHidden = true
                        self.loadingView.stopAnimating()
                    case .loading:
                        self.imageView.isHidden = true
                        self.imageView.image = nil
                        self.loadingView.isHidden = false
                        self.loadingView.startAnimating()
                    case .loaded(let image):
                        self.imageView.isHidden = false
                        self.imageView.image = image
                        self.loadingView.isHidden = true
                        self.loadingView.stopAnimating()
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}
