//
//  FavoriteListCoordinator.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 17.07.2023.


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
        let storyboard = UIStoryboard(name: Constants.System.Storyboard.favorites, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: Constants.System.Controller.favoriteListViewController) as! FavoriteListViewController
        
        let viewModel = FavoriteListViewModel()
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        
        navigationController.setViewControllers([viewController], animated: true)
        rootViewController = navigationController
    }
}
