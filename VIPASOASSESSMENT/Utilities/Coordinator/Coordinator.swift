//
//  Coordinator.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import UIKit

// MARK: - Coordinator

open class Coordinator: NSObject {
    public weak var parentCoordinator: Coordinator?
    
    public var childCoordinators = [Coordinator]()
    
    public let rootViewController: UIViewController
    var isPresented: Bool = false
    
    public init(rootViewController: UIViewController? = nil) {
        self.rootViewController = rootViewController ?? UIViewController()
        
        super.init()
    }
    
    func prepareForModalPresentation() {
        isPresented = true
        guard rootViewController.presentationController?.delegate == nil else {
            fatalError("Make sure Coordinator takes over the delegate - for handling UIAdaptivePresentationControllerDelegate")
        }
        rootViewController.presentationController?.delegate = self
    }
    
    public func addChild(_ coordinator: Coordinator) {
        print("add child: \(String(describing: coordinator.self))")
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
    }
    
    public func removeChild(_ coordinator: Coordinator) {
        guard let index = childCoordinators.firstIndex(of: coordinator) else { return }
            let removedCoordinator = childCoordinators.remove(at: index)
            removedCoordinator.parentCoordinator = nil
            print("remove child: \(String(describing: coordinator.self))")
    }
    
    public func removeAllChildren() {
        childCoordinators.removeAll()
    }
    
    // MARK: - Present
    
    public func present(_ coordinator: Coordinator, animated: Bool, completion: (() -> Void)? = nil) {
        addChild(coordinator)
        coordinator.prepareForModalPresentation()
        rootViewController.present(coordinator.rootViewController, animated: animated, completion: completion)
    }
    
    public func dismissChildCoordinator(animated: Bool, completion: (() -> Void)? = nil) {
        guard let coordinator = childCoordinators.first(where: { $0.rootViewController.presentingViewController != nil }) else { return }
        
        print("dismiss coordinator")
        
        coordinator.rootViewController.presentingViewController?.dismiss(animated: animated, completion: { [weak self] in
            self?.removeChild(coordinator)
            completion?()
        })
    }
    
    // MARK: - Start
    
    open func start() {}
    
    deinit {
        print("deinit coordinator: \(String(describing: self))")
    }
}

// MARK: - CoordinatorPresentationDelegate
extension Coordinator: UIAdaptivePresentationControllerDelegate {
    
    open func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        if let parentCoordinator = parentCoordinator {
            parentCoordinator.removeChild(self)
        }
    }
}
