//
//  NavigationCoordinator.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import UIKit

open class NavigationCoordinator: Coordinator {
    public var pushedViewControllers: [UIViewController]
    public let navigationController: UINavigationController

    // NavigationCoordinator can only have one child coordinator
    var childCoordinator: Coordinator? {
        return childCoordinators.first
    }

    public init(navigationController: UINavigationController? = nil) {
        pushedViewControllers = []
        self.navigationController = navigationController ?? UINavigationController()

        super.init(rootViewController: self.navigationController)

        if self.navigationController.delegate == nil {
            self.navigationController.delegate = self
        }
    }

    open func removePushedViewController(_ viewController: UIViewController) {
        guard let index = pushedViewControllers.firstIndex(of: viewController) else { return }

        pushedViewControllers.remove(at: index)
        print("remove: \(String(describing: pushedViewControllers.count)) from \(self)")
        if let parentCoordinator = parentCoordinator as? NavigationCoordinator, pushedViewControllers.isEmpty {
            parentCoordinator.removeChild(self)
            handOverDelegates(to: parentCoordinator) // give delegate back to parent
        }
    }

    // MARK: - ViewController

    open func push(_ viewController: UIViewController, animated: Bool) {
        pushedViewControllers.append(viewController)
        print("append: \(pushedViewControllers.count)")

        navigationController.pushViewController(viewController, animated: animated)
    }

    @objc open func popViewController(animated: Bool) {
        if let viewController = navigationController.popViewController(animated: animated) {
            removePushedViewController(viewController)
        }
    }

    public func popToViewController(_ viewController: UIViewController, animated: Bool) {
        guard let poppedViewControllers = navigationController.popToViewController(viewController, animated: animated) else { return }

        for vc in poppedViewControllers {
            removePushedViewController(vc)
        }
    }

    public func popToViewControllerOfType<T: UIViewController>(_: T.Type, animated: Bool, willPopToViewController: ((T) -> Void)? = nil) {
        guard let viewController = pushedViewControllers.first(where: { $0 is T }) as? T else { return }
        willPopToViewController?(viewController)
        popToViewController(viewController, animated: animated)
    }

    public func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        navigationController.present(viewController, animated: animated, completion: completion)
    }

    public func dismiss(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        viewController.presentingViewController?.dismiss(animated: animated, completion: completion)
    }

    // MARK: - Coordinator

    public func push(_ coordinator: NavigationCoordinator, animated _: Bool) {
        assert(coordinator.navigationController == navigationController, "Navigation Coordinator should only be pushed on the same UINavigationController! Hand over existing UINavigationController in init!")
        addChild(coordinator)

        coordinator.isPresented = isPresented
        handOverDelegates(to: coordinator) // hand delegate to next coordinator
    }

    public func popCoordinator(animated: Bool) {
        if let lastViewController = pushedViewControllers.last {
            navigationController.popToViewController(lastViewController, animated: animated)
        }
        if let childCoordinator = childCoordinator {
            removeChild(childCoordinator)
        }

        handOverDelegates(to: self) // I am the delegate now
    }

    func handOverDelegates(to navigationCoordinator: NavigationCoordinator) {
        navigationController.delegate = navigationCoordinator
        if isPresented {
            navigationController.presentationController?.delegate = navigationCoordinator
        }
    }

    // MARK: - Reset

    public func popToRoot(animated: Bool) {
        removeAllChildren()

        if let first = pushedViewControllers.first {
            pushedViewControllers = [first]
        }

        navigationController.dismiss(animated: animated, completion: nil)
        navigationController.popToRootViewController(animated: false)
    }
}

// MARK: - UINavigationControllerDelegate

extension NavigationCoordinator: UINavigationControllerDelegate {

    open func navigationController(_ navigationController: UINavigationController, didShow _: UIViewController, animated _: Bool) {
        // see https://stackoverflow.com/questions/36503224/ios-app-freezes-on-pushviewcontroller
        navigationController.interactivePopGestureRecognizer?.isEnabled = navigationController.viewControllers.count > 1

        // ensure the view controller is popping
        if let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), navigationController.viewControllers.contains(fromViewController) == false {
            removePushedViewController(fromViewController)
        }
    }
}
