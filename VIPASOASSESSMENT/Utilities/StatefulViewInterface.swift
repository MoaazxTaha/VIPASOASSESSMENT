//
//  StatefulProtocole.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation
import UIKit

protocol StatefulViewInterface {
    var emptyView: StatefulView { get }
    var errorView: StatefulView { get }
    var noNetwork: StatefulView { get }
    var loadingView: LoadingView { get }
    func setupStatefulView()
    func handleStateChange(state: ViewState)
}

extension StatefulViewInterface {
    func setupStatefulView() {

        emptyView.withConstraints {
            $0.alignEdges()
        }

        errorView.withConstraints {
            $0.alignEdges()
        }

        noNetwork.withConstraints {
            $0.alignEdges()
        }

        loadingView.withConstraints {
            $0.alignEdges()
        }
    }

    func handleStateChange(state: ViewState) {
        switch state {
        case .loading:
            loadingView.isHidden = false
            emptyView.isHidden = true
            errorView.isHidden = true
            noNetwork.isHidden = true
        case .loaded(let array) where array.isEmpty:
            loadingView.isHidden = true
            emptyView.isHidden = false
            errorView.isHidden = true
            noNetwork.isHidden = true
        case .loaded:
            loadingView.isHidden = true
            emptyView.isHidden = true
            errorView.isHidden = true
            noNetwork.isHidden = true
        case .error(let error):
            guard let error = error as? NetworkError else {
                loadingView.isHidden = true
                emptyView.isHidden = true
                errorView.isHidden = true
                noNetwork.isHidden = false
                return
            }

            switch error {
            case .connectionFailure:
                loadingView.isHidden = true
                emptyView.isHidden = true
                errorView.isHidden = true
                noNetwork.isHidden = false
            default:
                loadingView.isHidden = true
                emptyView.isHidden = true
                errorView.isHidden = false
                noNetwork.isHidden = true
            }
        }
    }
}
