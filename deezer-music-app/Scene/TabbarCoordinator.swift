//
//  TabbarCoordinator.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 12.07.2023.
//

import UIKit


final class TabbarCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var rootViewController: UIViewController?
    var tabbarController: UITabBarController
    
    init(tabbarController: UITabBarController, navigationController: UINavigationController) {
        self.tabbarController = tabbarController
        self.navigationController = navigationController
        self.rootViewController = tabbarController
    }
    
    func start() {
        tabbarController.viewControllers = setupViewControllers()
    }
    
    func setupViewControllers() ->[UIViewController] {
        
        var viewControllers: [UIViewController] = []
        let genreCoordinator = GenreListCoordinator(navigationController: navigationController)
        childCoordinators.append(genreCoordinator)
        genreCoordinator.start()
        let genreVC = genreCoordinator.rootViewController
        let tabbarItem = UITabBarItem(title: "Genre", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        genreVC?.tabBarItem = tabbarItem
        if let genreVC = genreVC {
            viewControllers.append(genreVC)
        }
        return viewControllers
    }
    
    
    
}
