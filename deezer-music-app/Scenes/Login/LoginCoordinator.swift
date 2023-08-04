//
//  LoginCoordinator.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 1.08.2023.
//

import UIKit.UINavigationController

final class LoginCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var rootViewController: UIViewController?
    
    var tabbarController: TabBarController
    var window: UIWindow?
    
    init(navigationController: UINavigationController, tabbarController: TabBarController) {
        self.navigationController = navigationController
        self.tabbarController = tabbarController
    }
    
    func start() {
        navigationController.navigationBar.tintColor = .red
        let storyboard = UIStoryboard(name: Constants.System.Storyboard.login , bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: Constants.System.Controller.loginViewController) as! LoginViewController
        
        let viewModel = LoginViewModel()
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        
        navigationController.setViewControllers([viewController], animated: true)
        rootViewController = navigationController
        
    }
    
    func showRegister() {
        let registerCoordinator = RegisterCoordinator(navigationController: navigationController)
        childCoordinators.append(registerCoordinator)
        registerCoordinator.start()
    }
    
    func showTabbar() {
        
        
        let navigationController = UINavigationController()
        let coordinator = TabbarCoordinator(tabbarController: tabbarController, navigationController: navigationController)
        window?.rootViewController = coordinator.tabbarController
        window?.makeKeyAndVisible()
        coordinator.start()
        
    }
}
