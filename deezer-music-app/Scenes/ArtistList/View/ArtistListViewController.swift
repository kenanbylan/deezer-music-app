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
        
        //viewModel.delegate = self
        viewModel.viewDidLoad()
        
        //TODO: register collectionView
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backButtonTapped() {
        coordinator?.goBack()
    }
}
