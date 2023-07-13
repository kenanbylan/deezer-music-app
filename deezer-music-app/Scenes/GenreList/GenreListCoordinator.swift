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
        let storyboard = UIStoryboard(name: "GenreList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "GenreListViewController") as! GenreListViewController
        let service = GenreListService()
        let viewModel = GenreListViewModel(service: service)
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        rootViewController = viewController
    }
    
    //MARK: - END OF ERROR QUEUE.
    
    func showArtistList(genreId: Int) {
        print("Clicked data: ",genreId)
        let storyboard = UIStoryboard(name: "ArtistList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ArtistListViewController") as! ArtistListViewController
        
        //navigationController.show(viewController, sender: nil)
        navigationController.pushViewController(viewController, animated: true)
        
        //        navigationController.pushViewController(viewController, animated: true)
        //        let artistListCoordinator = ArtistListCoordinator(navigationController: navigationController, genreId: genreId)
        //        childCoordinators.append(artistListCoordinator)
        //        artistListCoordinator.start()
    }
    
}
