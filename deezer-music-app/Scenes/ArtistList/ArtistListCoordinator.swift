//
//  ArtistListCoordinator.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 12.07.2023.
//

import UIKit

//MARK: ASK HERE !!

class ArtistListCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var rootViewController: UIViewController?
    
    var genreId: Int
    
    init(navigationController: UINavigationController,genreId: Int) {
        self.navigationController = navigationController
        self.genreId = genreId
    }
    
    func start() {
        let artistListStoryboard = UIStoryboard(name: "ArtistList", bundle: nil)
        let artistListViewController = artistListStoryboard.instantiateViewController(withIdentifier: "ArtistListViewController") as! ArtistListViewController
        
        let artistListService = ArtistListService()
        let viewModel = ArtistListViewModel(artistListService: artistListService)
        viewModel.genreId = genreId
        viewModel.coordinator = self
        
        artistListViewController.viewModel = viewModel
        navigationController.pushViewController(artistListViewController, animated: true)
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
