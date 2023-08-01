//
//  ArtistTrackViewController.swift
//  deezer-music-app

//  Created by Kenan Baylan on 15.07.2023.

import UIKit

final class ArtistAlbumViewController: UIViewController {
    
    @IBOutlet private weak var artistTrackCollectionView: UICollectionView!
    private weak var coordinator: ArtistAlbumCoordinator?
    private let refreshControl = UIRefreshControl()
    
    var viewModel: ArtistAlbumViewModelProtocol! { didSet { viewModel.delegate  = self } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        
        setupCollectionView()
        setupRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupRefreshControl()
        setupCollectionView()
    }
}

//MARK: - ArtistAlbumViewController Setup func.
extension ArtistAlbumViewController {
    
    private func setupCollectionView() {
        artistTrackCollectionView.delegate = self
        artistTrackCollectionView.dataSource = self
        artistTrackCollectionView.register(ArtistAlbumCollectionViewCell.self)
    }
    
    private func setupRefreshControl() {
        artistTrackCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        artistTrackCollectionView.reloadData()
    }
    
    @objc private func refreshData() {
        viewModel.viewDidLoad()
        artistTrackCollectionView.reloadData()
        refreshControl.endRefreshing()
    }
}

//MARK: ArtistTrackViewModelDelegate

extension ArtistAlbumViewController: ArtistAlbumViewModelDelegate {
    func handleViewModelOutput(_ output: ArtistAlbumViewModelOutput) {
        switch output {
        case .showTitle(let title):
            self.navigationItem.title = title
        case .showArtistAlbumList(_):
            artistTrackCollectionView.reloadData()
        case .showError(errorDescription: let errorDescription):
            self.presentErrorAlert(title: "Error", message: errorDescription)
        case .succesAddFavorite(_):
            artistTrackCollectionView.reloadData()
        case .failureAddFavorite(let error):
            self.presentErrorAlert(title: "Error", message: error.localizedDescription)
            artistTrackCollectionView.reloadData()
        }
    }
}

//MARK: UICollectionViewDataSource

extension ArtistAlbumViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfAlbum()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: ArtistAlbumCollectionViewCell.self),
            for: indexPath) as? ArtistAlbumCollectionViewCell
        
        guard let albumData = viewModel.albumDataAt(index: indexPath.item) else { return UICollectionViewCell() }
        cell?.delegate = self
        cell?.updateUIWith(albumData: albumData)
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectAlbumAt(index: indexPath.item)
    }
}

extension ArtistAlbumViewController: UICollectionViewDelegate { }

extension ArtistAlbumViewController: ArtistAlbumCollectionViewCellDelegate {
    
    func favoriteImageViewTapped(id: Int, isFavorite: Bool) {
        if isFavorite {
            viewModel.favoriteAlbum(selectTrackId: id)
        } else {
            viewModel.removeFavoriteAlbum(selectTrackId: id)
        }
        artistTrackCollectionView.reloadData()
    }
}
