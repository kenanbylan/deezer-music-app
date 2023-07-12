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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(with genre: GenreResponse) {
        
        let storyboard = UIStoryboard(name: "ArtistList", bundle: nil)
        let artistListViewController = storyboard.instantiateViewController(withIdentifier: "ArtistListViewController") as! ArtistListViewController
        
        let artistListService = ArtistListService() // Gerekli servisi oluşturun
        let viewModel = ArtistListViewModel(artistListService: artistListService)
        artistListViewController.viewModel = viewModel
        navigationController.pushViewController(artistListViewController, animated: true)
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
