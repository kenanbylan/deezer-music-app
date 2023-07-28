//
//  FavoriteListCoordinator.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 17.07.2023.
//

import UIKit.UINavigationController

final class FavoriteListCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var rootViewController: UIViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("Favorite clicked.")
        let storyboard = UIStoryboard(name: "FavoriteList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FavoriteListViewController") as! FavoriteListViewController
        
        let viewModel = FavoriteListViewModel()
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        
        navigationController.setViewControllers([viewController], animated: true)
        rootViewController = navigationController
    }
}

