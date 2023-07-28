//  GenreListCoordinator.swift
//  deezer-music-app
//  Created by Kenan Baylan on 10.07.2023.

import UIKit.UINavigationController

final class GenreListCoordinator: Coordinator {    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var rootViewController: UIViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.navigationBar.tintColor = .red
        
        let storyboard = UIStoryboard(name: Constants.System.Storyboard.genre , bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: Constants.System.Controller.genreController) as! GenreListViewController
        
        let service = GenreListService()
        let viewModel = GenreListViewModel(service: service)
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        
        navigationController.setViewControllers([viewController], animated: true)
        rootViewController = navigationController
    }
    
    func showArtistList(genre: GenreResponse) {
        let artistListCoordinator = ArtistListCoordinator(navigationController: navigationController, selectGenre: genre)
        childCoordinators.append(artistListCoordinator)
        artistListCoordinator.start()
    }
}
