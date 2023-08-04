//
//  SettingCoordinator.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 29.07.2023.
//

import UIKit.UINavigationController

final class SettingCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var rootViewController: UIViewController?
    var window: UIWindow?
    
    var tabbarController: TabBarController
    
    init(navigationController: UINavigationController,tabbarController: TabBarController) {
        self.navigationController = navigationController
        self.tabbarController = tabbarController
        
    }
    
    func start() {
        let storyboard = UIStoryboard(name: Constants.System.Storyboard.settings , bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: Constants.System.Controller.settingViewController) as! SettingViewController
        
        let viewModel = SettingViewModel()
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        navigationController.setViewControllers([viewController], animated: true)
        rootViewController = navigationController
        
    }
    
    func navigateToLogin() {
        
        tabbarController.setViewControllers([], animated: true)
        
        let loginNavigationController = UINavigationController()
        loginNavigationController.hidesBarsOnSwipe = true
        let loginCoordinator = LoginCoordinator(navigationController: navigationController,tabbarController: tabbarController)
        
        childCoordinators.removeAll()
        self.window?.rootViewController = loginNavigationController
        self.navigationController = loginNavigationController
        loginCoordinator.start()
    }
}
