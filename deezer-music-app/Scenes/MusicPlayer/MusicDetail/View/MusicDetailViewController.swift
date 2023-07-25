//
//  MusicDetailViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 24.07.2023.
//

import UIKit

final class MusicDetailViewController: UIViewController {
    
    var viewModel: MusicDetailViewModelProtocol! {
        didSet { viewModel.delegate = self }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen
    }
    
}

extension MusicDetailViewController: MusicDetailViewModelDelegate {
    
    func handleViewModelOutput(_ output: MusicDetailViewModelOutput) {
        switch output {
        case .setTitle(let title):
            break
        }
    }
    
}
