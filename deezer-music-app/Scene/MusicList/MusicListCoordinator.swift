//
//  MusicListCoordinator.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 10.07.2023.
//

import Foundation
import UIKit

class MusicListCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    //TODO: will be fixed.
    func showArtist(artistId: Int) {
        let artistCoordinator = ArtistListCoordinator(navigationController: navigationController, artistId: artistId)
        artistCoordinator.start()
    }

}
