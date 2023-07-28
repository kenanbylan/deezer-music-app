//
//  ArtistTrackViewController.swift
//  deezer-music-app

//  Created by Kenan Baylan on 15.07.2023.

import UIKit
import AVFAudio

final class ArtistAlbumViewController: UIViewController {
    
    @IBOutlet private weak var artistTrackCollectionView: UICollectionView! {
        didSet {
            artistTrackCollectionView.delegate = self
            artistTrackCollectionView.dataSource = self
        }
    }
    
    private weak var coordinator: ArtistAlbumCoordinator?
    var audioPlayer:AVAudioPlayer?
    var viewModel: ArtistAlbumViewModelProtocol! { didSet { viewModel.delegate  = self } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
        artistTrackCollectionView.register(ArtistAlbumCollectionViewCell.self)
    }
}


//MARK: -ArtistAlbumViewController Setup func.

extension ArtistAlbumViewController {
    
}

//MARK: ArtistTrackViewModelDelegate

extension ArtistAlbumViewController: ArtistAlbumViewModelDelegate {
    func handleViewModelOutput(_ output: ArtistAlbumViewModelOutput) {
        switch output {
        case .showTitle(let title):
            self.navigationItem.title = title
        case .showArtistAlbumList(_):
            artistTrackCollectionView.reloadData()
        case .setLoading(_ ):
            break
        case .didSelectAlbum(_):
            break
            
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
        
        cell?.delegate = self
        
        if let albumData = viewModel.albumDataAt(index: indexPath.item) {
            cell?.id = albumData.trackId ?? 0
            cell?.updateUIWith(albumData: albumData)
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectAlbumAt(indexPath.item)
    }
}

extension ArtistAlbumViewController: UICollectionViewDelegate { }

extension ArtistAlbumViewController: ArtistAlbumCollectionViewCellDelegate {
    
    func favoriteImageViewTapped(id: Int, isFavorite: Bool) {
        if isFavorite {
            viewModel.favoriteAlbum(id)
        } else {
            viewModel.removeFavoriteAlbum(selectTrackId: id)
        }
    }
}
