//
//  GenreListCoordinator.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 10.07.2023.


import UIKit

//MARK: - Genre Coordinator

class GenreListCoordinator: Coordinator {
    
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
        viewController.viewModel = GenreListViewModel(service: service)
        viewController.coordinator = self
        rootViewController = viewController
    }
}
