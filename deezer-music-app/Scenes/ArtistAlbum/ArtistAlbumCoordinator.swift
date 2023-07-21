//
//  ArtistTrackCoordinator.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 15.07.2023.
//

import UIKit

class ArtistAlbumCoordinator: Coordinator {
    
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
        let artistTrackStoryboard = UIStoryboard(name: "ArtistAlbum", bundle: nil)
        let artistTrackViewController = artistTrackStoryboard.instantiateViewController(withIdentifier: "ArtistAlbumViewController") as! ArtistAlbumViewController
        
        
        let albumTrackService = AlbumTrackService()
        let viewModel = ArtistAlbumViewModel(albumTrackService: albumTrackService)
        
        
        viewModel.selectAlbumId = selectAlbumId
        viewModel.selectedAlbumName = selectedAlbumName
        viewModel.coordinator = self
        
        artistTrackViewController.viewModel = viewModel
        navigationController.pushViewController(artistTrackViewController, animated: true)
        
    }
    
    func showPlayMusic() { }
    
}
