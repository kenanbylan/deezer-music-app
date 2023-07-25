//
//  MusicDetailCoordinator.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 24.07.2023.
//

import UIKit.UINavigationController

final class MusicDetailCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var rootViewController: UIViewController?
    var selectMusicData: AlbumDetailTrackListData
    
    init(navigationController: UINavigationController, selectMusicData: AlbumDetailTrackListData) {
        self.navigationController = navigationController
        self.selectMusicData = selectMusicData
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "MusicDetail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MusicDetailViewController") as! MusicDetailViewController
        
        let viewModel = MusicDetailViewModel()
        viewModel.coordinator = self
        viewModel.selectPlayingMusic = selectMusicData
        viewController.viewModel = viewModel
        
        navigationController.setViewControllers([viewController], animated: true)
        rootViewController = navigationController
    }
}
