//
//  ArtistListCoordinator.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 12.07.2023.

import UIKit

class ArtistListCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var rootViewController: UIViewController?
    
    var selectGenre: GenreResponse
    
    init(navigationController: UINavigationController,selectGenre: GenreResponse) {
        self.navigationController = navigationController
        self.selectGenre = selectGenre
    }
    
    func start() {
        let artistListStoryboard = UIStoryboard(name: Constants.System.Storyboard.artistList , bundle: nil)
        let artistListViewController = artistListStoryboard.instantiateViewController(withIdentifier: Constants.System.Controller.artistListViewController) as! ArtistListViewController
        
        let artistListService = ArtistListService()
        let viewModel = ArtistListViewModel(artistListService: artistListService)
        viewModel.selectedGenre = selectGenre
        viewModel.coordinator = self
        
        artistListViewController.viewModel = viewModel
        navigationController.pushViewController(artistListViewController, animated: true)
    }
    
    func showArtistDetail(artist: ArtistListResponse) {
        let artistDetailCoordinator = ArtistDetailCoordinator(navigationController: navigationController, selectArtist: artist)
        childCoordinators.append(artistDetailCoordinator)
        artistDetailCoordinator.start()
    }
}
