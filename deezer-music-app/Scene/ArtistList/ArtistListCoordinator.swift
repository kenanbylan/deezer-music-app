//
//  ArtistListCoordinator.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 11.07.2023.
//

import Foundation


import UIKit


class ArtistListCoordinator: Coordinator {
    
    
    var navigationController: UINavigationController
    let artistId: Int
    
    init(navigationController: UINavigationController, artistId: Int) {
        self.navigationController = navigationController
        self.artistId = artistId
    }
    
    func start() {
        let artistViewController = ArtistListViewController(artistId: artistId)
        navigationController.pushViewController(artistViewController, animated: true)
    }
}
