//
//  ArtistDetailCoordinator.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 14.07.2023.
//

import UIKit

class ArtistDetailCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var rootViewController: UIViewController?
    
    var selectArtist: ArtistListResponse
    
    init(navigationController: UINavigationController,selectArtist: ArtistListResponse) {
        self.navigationController = navigationController
        self.selectArtist = selectArtist
    }
    
    func start() {
        let artistDetailStoryboard = UIStoryboard(name: "ArtistDetail", bundle: nil)
        let artistDetailViewController = artistDetailStoryboard.instantiateViewController(withIdentifier: "ArtistDetailViewController") as! ArtistDetailViewController

        let artistDetailService = ArtistDetailService()
        let viewModel = ArtistDetailViewModel(artistDetailService: artistDetailService)
        
        viewModel.selectArtist = selectArtist
        viewModel.coordinator = self
        
        artistDetailViewController.viewModel = viewModel
        
        navigationController.pushViewController(artistDetailViewController, animated: true)
    }
    
    func showArtistAlbum(albumData: AlbumData, artistAlbumDetail: [AlbumTracksData]) {
        //TODO: will be added.
        let artistTrackCoordinator = ArtistTrackCoordinator(navigationController: navigationController,albumData: albumData,artistAlbumDetail: artistAlbumDetail)
        
        childCoordinators.append(artistTrackCoordinator)
        artistTrackCoordinator.start()
    }
}
