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
    
    var tabBarController: TabBarController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
    
    func showTabBar() {
        tabBarController = TabBarController()
        navigationController.setViewControllers([tabBarController!], animated: true)
        rootViewController = navigationController
    }

    
}
