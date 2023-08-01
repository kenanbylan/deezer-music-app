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
}
