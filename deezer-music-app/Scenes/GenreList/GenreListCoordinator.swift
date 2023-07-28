//  GenreListCoordinator.swift
//  deezer-music-app
//  Created by Kenan Baylan on 10.07.2023.

import UIKit.UINavigationController

//MARK: - Genre Coordinator

final class GenreListCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var rootViewController: UIViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.navigationBar.tintColor = .red
        
        let storyboard = UIStoryboard(name: "GenreList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "GenreListViewController") as! GenreListViewController
        
        let service = GenreListService()
        let viewModel = GenreListViewModel(service: service)
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        
        
        navigationController.setViewControllers([viewController], animated: true)
        rootViewController = navigationController
    }
    
    //MARK: - END OF ERROR QUEUE.
    
    func showArtistList(genre: GenreResponse) {
        let artistListCoordinator = ArtistListCoordinator(navigationController: navigationController, selectGenre: genre)
        childCoordinators.append(artistListCoordinator)
        artistListCoordinator.start()
    }
    
    func showFavoritePage() {
        let favoriteCoordinator = FavoriteListCoordinator(navigationController: navigationController)
        childCoordinators.append(favoriteCoordinator)
        favoriteCoordinator.start()
        navigationController.pushViewController(favoriteCoordinator.rootViewController!, animated: true)
    }
    
    
    
}
