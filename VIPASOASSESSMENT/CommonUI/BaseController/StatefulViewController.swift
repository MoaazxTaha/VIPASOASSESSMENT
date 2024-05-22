//
//  StatefulViewController.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation
import UIKit

open class StatefulViewController: UIViewController {
    
    lazy var emptyView = StatefulView.emptyView().with { $0.isHidden = true }
    lazy var errorView = StatefulView.genericError().with { $0.isHidden = true }
    lazy var noNetwork = StatefulView.noNetwork().with { $0.isHidden = true }
    var loadingView: LoadingView =  LoadingView()
    
    // MARK: - View cycle

    open override func viewDidLoad() {
        super.viewDidLoad()

        addStatefulViews()
        setupStatefulView()
        loadingView.startLoading()
    }

     open func addStatefulViews() {
        view.addSubview(emptyView)
        view.addSubview(noNetwork)
        view.addSubview(errorView)
        view.addSubview(loadingView)
    }
}

extension StatefulViewController: StatefulViewInterface {}
