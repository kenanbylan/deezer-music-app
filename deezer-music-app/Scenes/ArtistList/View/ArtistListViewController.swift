//
//  ArtistListViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 12.07.2023.
//

import UIKit

final class ArtistListViewController: UIViewController {
    
    @IBOutlet private weak var artistListCollectionView: UICollectionView!
    
    private weak var coordinator: ArtistListCoordinator?
    
    var viewModel: ArtistListViewModelProtocol! {
        didSet {
            viewModel.delegate  = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artistListCollectionView.delegate = self
        artistListCollectionView.dataSource = self
        registerCollectionView()
        viewModel.viewDidLoad()
    }
    
    private func registerCollectionView() {
        artistListCollectionView.register(CategoryCollectionViewCell.self)
    }
}

extension ArtistListViewController: ArtistListViewModelDelegate {
    func handleViewModelOutput(_ output: ArtistListViewModelOutput) {
        switch output {
        case .showArtistList(_):
            self.artistListCollectionView.reloadData()
        case .setLoading(_):
            break
        case .showTitle(let title):
            self.navigationItem.title = title
        }
    }
}


extension ArtistListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.artistList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: CategoryCollectionViewCell.self),
            for: indexPath) as! CategoryCollectionViewCell
        
        if let artist = viewModel.artistAt(indexPath.item) {
            cell.updateUIWith(artist: artist )
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectArtistAtIndex(indexPath.item)
    }
}

extension ArtistListViewController: UICollectionViewDelegateFlowLayout {
    
}
