//
//  UsersSearchCoordinator.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation
import UIKit
import RxSwift
import RxRelay
import SwiftUI

class UsersSearchCoordinator: NavigationCoordinator {
    // MARK: - init
    override init(navigationController: UINavigationController? = nil) {
        // add app signature color to naviagtion bar items tint
        navigationController?.navigationBar.tintColor = Colors.appSignatureColor.color
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        let viewModel = UsersSearchViewModel()

        let viewController = UsersSearchViewController(viewModel: viewModel) { [weak self] action in
            switch action {
                case .sendEmail(let userInfo):
                    self?.showUserDetails(for: userInfo)
            }
        }
                
        push(viewController, animated: true)
    }
        
    // MARK: - navigation
    
    private func showUserDetails(for userInfo: UserInfo) {
        let userDetailCoordinator = UserDetailCoordinator(navigationController: navigationController)
        userDetailCoordinator.start(userInfo: userInfo)
        push(userDetailCoordinator, animated: true)
    }
}
