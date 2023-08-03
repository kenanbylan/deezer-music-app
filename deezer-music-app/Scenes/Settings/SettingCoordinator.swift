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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
        let loginNavigationController = UINavigationController()
        loginNavigationController.hidesBarsOnSwipe = true
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        
        childCoordinators.removeAll()
        self.window?.rootViewController = loginNavigationController
        self.navigationController = loginNavigationController
        loginCoordinator.start()
    
    }
}


//func startNavigationFromHome() {
//    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//    let nav = storyboard.instantiateViewController(withIdentifier: AZNavigationController.className) as? AZNavigationController
//    guard let mainNavigationController = nav else { return }
//    self.window.rootViewController = mainNavigationController
//    self.navigationController = mainNavigationController
//}
//
//func startNavigationFromAuthentication(with deeplink: (() -> Void)? = nil) {
//    let loginNavigationController = UINavigationController()
//    loginNavigationController.hidesBarsOnSwipe = true
//    let loginCoordinator = AZAuthenticationCoordinator(navC: loginNavigationController)
//    childCoordinators.append(loginCoordinator)
//    self.window.rootViewController = loginNavigationController
//    self.navigationController = loginNavigationController
//    loginCoordinator.start(withDeeplink: deeplink)
//}

