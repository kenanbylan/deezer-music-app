//
//  ArtistDetailCoordinator.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 14.07.2023.
//

import UIKit.UINavigationController

final class ArtistDetailCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var rootViewController: UIViewController?
    
    var selectArtist: ArtistListResponse
    
    init(navigationController: UINavigationController,selectArtist: ArtistListResponse) {
        self.navigationController = navigationController
        self.selectArtist = selectArtist
    }
    
    func start() {
        
        let artistDetailStoryboard = UIStoryboard(name: Constants.System.Storyboard.artistDetail , bundle: nil)
        let artistDetailViewController = artistDetailStoryboard.instantiateViewController(withIdentifier: Constants.System.Controller.artistDetailViewController ) as! ArtistDetailViewController
        
        let artistDetailService = ArtistDetailService()
        let viewModel = ArtistDetailViewModel(artistDetailService: artistDetailService)
        
        viewModel.selectArtist = selectArtist
        viewModel.coordinator = self
        artistDetailViewController.viewModel = viewModel
        navigationController.pushViewController(artistDetailViewController, animated: true)
    }
    
    func showArtistAlbum(albumId: Int, albumName: String) {
        let artistAlbumCoordinator = ArtistAlbumCoordinator(navigationController: navigationController, selectAlbumId: albumId, selectedAlbumName: albumName)
        childCoordinators.append(artistAlbumCoordinator)
        artistAlbumCoordinator.start()
    }
    
}
