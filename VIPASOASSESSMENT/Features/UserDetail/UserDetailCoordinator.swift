//
//  UserDetailCoordinator.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation
import UIKit
import RxSwift
import RxRelay
import SwiftUI

class UserDetailCoordinator: NavigationCoordinator {
    // MARK: - init
    override init(navigationController: UINavigationController? = nil) {
        super.init(navigationController: navigationController)
    }
    
    func start(userInfo: UserInfo) {
        let viewModel = UserDetailViewMdoel(userInfo: userInfo)
        let userProfileView = UserDetailView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: userProfileView)

        push(viewController, animated: true)
    }
}
