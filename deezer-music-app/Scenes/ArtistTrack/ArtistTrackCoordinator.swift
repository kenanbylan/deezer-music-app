//
//  ArtistTrackCoordinator.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 15.07.2023.
//

import UIKit

class ArtistTrackCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var rootViewController: UIViewController?
    
    var albumData: AlbumData
    var artistAlbumDetail: [AlbumTracksData]

    init(navigationController: UINavigationController,albumData: AlbumData, artistAlbumDetail: [AlbumTracksData]) {
        self.navigationController = navigationController
        self.albumData = albumData
        self.artistAlbumDetail = artistAlbumDetail
    }
    
    func start() {
        let artistTrackStoryboard = UIStoryboard(name: "ArtistTrack", bundle: nil)
        let artistTrackViewController = artistTrackStoryboard.instantiateViewController(withIdentifier: "ArtistTrackViewController") as! ArtistTrackViewController
        
        let albumTrackService = AlbumTrackService()
        let viewModel = ArtistTrackViewModel(artistTrackService: albumTrackService)
        
        viewModel.artistAlbumData = albumData
        viewModel.artistAlbumDetail = artistAlbumDetail
        viewModel.coordinator = self
        
        artistTrackViewController.viewModel = viewModel
        navigationController.pushViewController(artistTrackViewController, animated: true)
        
    }
    
    func showPlayMusic() { }
    
}
