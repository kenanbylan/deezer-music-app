//
//  FavoriteListCoordinator.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 17.07.2023.
//

import UIKit.UINavigationController

final class FavoriteListCoordinator: Coordinator {
    
    weak var tabBarController: TabBarController?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var rootViewController: UIViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "FavoriteList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FavoriteListViewController") as! FavoriteListViewController
        
        let viewModel = FavoriteListViewModel()
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        
        if let tabBarController = navigationController.tabBarController as? TabBarController {
            viewModel.miniBarDelegate = tabBarController
        }
        
        navigationController.setViewControllers([viewController], animated: true)
        rootViewController = navigationController
    }
}

