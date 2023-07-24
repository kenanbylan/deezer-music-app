//
//  FavoriteListViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 17.07.2023.
//

import UIKit

final class FavoriteListViewController: UIViewController {
    
    var viewModel: FavoriteListViewModelProtocol! {
        didSet { viewModel.delegate = self }
    }
    
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupCollectionView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewDidLoad()
    }
    
    private func setupCollectionView() {
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.register(ArtistAlbumCollectionViewCell.self)
    }
}

extension FavoriteListViewController: FavoriteListViewModelDelegate {
    func handleViewModelOutput(_ output: FavoriteListViewModelOutput) {
        
        switch output {
        case .showFavoriteList(_):
            favoriteCollectionView.reloadData()
        case .setTitle(let title):
            self.navigationItem.title = title
        case .setLoading(_):
            break
        case .successRemoved(_):
            favoriteCollectionView.reloadData()
        }
    }
}

extension FavoriteListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfFavorites()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = CollectionCellIdentifier.artistAlbumCell.rawValue
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? ArtistAlbumCollectionViewCell
        
        
        cell?.delegate = self
        
        if let favoriteData = viewModel.favoriteAt(index: indexPath.item) {
            cell?.id = Int(favoriteData.id)
            cell?.updateUIWith(albumData: favoriteData)
        }
        
        return cell ?? UICollectionViewCell()
    }
}

extension FavoriteListViewController: UICollectionViewDelegate { }

extension FavoriteListViewController: ArtistAlbumCollectionViewCellDelegate {
    func favoriteImageViewTapped(id: Int, isFavorite: Bool) {
        if isFavorite {
            viewModel.removeFavoriteById(selectTrackId: id)
        } else {
            print("id: \(id) is not favorite")
        }
    }
}
