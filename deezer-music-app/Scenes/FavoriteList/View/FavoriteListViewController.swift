//
//  FavoriteListViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 17.07.2023.
//

import UIKit

class FavoriteListViewController: UIViewController {
    var viewModel: FavoriteListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}


extension FavoriteListViewController: FavoriteListViewModelDelegate {
    
    func handleViewModelOutput(_ output: FavoriteListViewModelOutput) {
        
        switch output {
        case .showFavoriteList(_):
            break
        case .setTitle(let title):
            break
            
        case .setLoading(let load):
            break
        }
    }
    
}
