//  TabbarCoordinator.swift
//  deezer-music-app
//  Created by Kenan Baylan on 12.07.2023.

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
        navigationController.navigationBar.tintColor = .red
    }
    
    func setupViewControllers() -> [UIViewController] {
        var viewControllers: [UIViewController] = []
        
        //MARK: Genre Tabbar Item
        let genreCoordinator = GenreListCoordinator(navigationController: UINavigationController())
        childCoordinators.append(genreCoordinator)
        genreCoordinator.start()
        
        let genreVC = genreCoordinator.rootViewController
        let genreTabBarItem = UITabBarItem(title: "Home", image: UIImage(named: Constants.Image.home), selectedImage: UIImage(named: "home"))
        genreVC?.tabBarItem = genreTabBarItem
        if let genreVC = genreVC { viewControllers.append(genreVC) }
        
        //MARK: Favorite Tabbar Item
        let favoriteCoordinator = FavoriteListCoordinator(navigationController: UINavigationController())
        childCoordinators.append(favoriteCoordinator)
        favoriteCoordinator.start()
        
        let favoriteVC = favoriteCoordinator.rootViewController
        let favoriteTabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named: Constants.Image.favorites), selectedImage: UIImage(named: "fav"))
        favoriteVC?.tabBarItem = favoriteTabBarItem
        
        if let favoriteVC = favoriteVC { viewControllers.append(favoriteVC) }
        return viewControllers
    }
    
    func showMusicDetail(musicDetail: AlbumDetailTrackListData) {
        let storyboard = UIStoryboard(name: Constants.System.Storyboard.musicDetail, bundle: nil)
        guard let musicDetailVC = storyboard.instantiateViewController(withIdentifier: Constants.System.Controller.musicDetailViewController) as? MusicDetailViewController else { return }
        
        let musicDetailViewModel = MusicDetailViewModel(selectPlayingMusic: musicDetail)
        musicDetailVC.viewModel = musicDetailViewModel
        
        //Next Track detail page's
        UIApplication.topViewController()?.present(musicDetailVC, animated: true, completion: nil)
    }
}
