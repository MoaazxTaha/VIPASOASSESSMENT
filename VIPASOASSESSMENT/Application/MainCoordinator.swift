//
//  MainCoordinator.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation
import UIKit

class MainCoordinator: NavigationCoordinator {
    
    static let shared = MainCoordinator()
    var window: UIWindow!

    override init(navigationController: UINavigationController? = nil) {
        super.init(navigationController: UINavigationController())
    }
    
    func start(window: UIWindow) {
        let coordinator = UsersSearchCoordinator(navigationController: navigationController)
        coordinator.start()
        
        addChild(coordinator)
        
        window.rootViewController = coordinator.rootViewController
        window.makeKeyAndVisible()
    }
}
