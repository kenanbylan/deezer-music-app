//
//  ArtistListViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 12.07.2023.
//

import UIKit

class ArtistListViewController: UIViewController {
    
    weak var coordinator: ArtistListCoordinator?
    var viewModel: ArtistListViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   viewModel.delegate = self
       // viewModel.viewDidLoad()
        
        //TODO: register collectionView
    }
}

extension ArtistListViewController: ArtistListViewModelDelegate {
    func handleViewModelOutput(_ output: ArtistListViewModelOutput) {
        //TODO:
    }
}
