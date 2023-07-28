//
//  ArtistTrackCoordinator.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 15.07.2023.
//

import UIKit

final class ArtistAlbumCoordinator: Coordinator {
    
    weak var tabBarController: TabBarController?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var rootViewController: UIViewController?
    
    var selectAlbumId: Int
    var selectedAlbumName: String
    
    init(navigationController: UINavigationController, selectAlbumId: Int, selectedAlbumName: String) {
        self.navigationController = navigationController
        self.selectAlbumId = selectAlbumId
        self.selectedAlbumName = selectedAlbumName
    }
    
    func start() {
        let artistTrackStoryboard = UIStoryboard(name: Constants.System.Storyboard.artistAlbum , bundle: nil)
        let artistTrackViewController = artistTrackStoryboard.instantiateViewController(withIdentifier: Constants.System.Controller.artistAlbumViewController) as! ArtistAlbumViewController
        
        let albumTrackService = AlbumTrackService()
        let viewModel = ArtistAlbumViewModel(albumTrackService: albumTrackService)
        
        viewModel.selectAlbumId = selectAlbumId
        viewModel.selectedAlbumName = selectedAlbumName
        viewModel.coordinator = self
        
        if let tabBarController = navigationController.tabBarController as? TabBarController {
            viewModel.miniBarDelegate = tabBarController
        }
        
        artistTrackViewController.viewModel = viewModel
        navigationController.pushViewController(artistTrackViewController, animated: true)
    }
    
    func showPlayMusic() { }
}
