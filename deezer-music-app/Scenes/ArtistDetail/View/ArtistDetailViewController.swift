//
//  ArtistDetailViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 14.07.2023.

import UIKit
import Kingfisher

final class ArtistDetailViewController: UIViewController {
    @IBOutlet private weak var artistDetailCollectionView: UICollectionView!
    private weak var coordinator: ArtistDetailCoordinator?
    var viewModel: ArtistDetailViewModelProtocol! {
        didSet {
            viewModel.delegate  = self
        }
    }
    
    var selectartistAlbumImage: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        artistDetailCollectionView.delegate = self
        artistDetailCollectionView.dataSource = self
        artistDetailCollectionView.register(AlbumCollectionViewCell.self)
    }
}

//MARK: ArtistDetailViewModelDelegate

extension ArtistDetailViewController : ArtistDetailViewModelDelegate {
    func handleVieModelOutput(_ output: ArtistDetailViewModelOutput) {
        switch output {
        case .showArtistDetail(_):
            self.artistDetailCollectionView.reloadData()
        case .setLoading(_):
            break
        case .showArtistAlbum(_):
            self.artistDetailCollectionView.reloadData()
            
        case .showTitle(let title):
            self.navigationItem.title = title
            
        case .showTitleImage(let image):
            self.selectartistAlbumImage = image
            self.artistDetailCollectionView.reloadData()
        }
    }
}

extension ArtistDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.artistAlbumDetail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: AlbumCollectionViewCell.self),
            for: indexPath) as! AlbumCollectionViewCell
        
        cell.updateUIWith(artistAlbum: viewModel.artistAlbumDetail[indexPath.item])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
        
        headerView.updateWith(image: selectartistAlbumImage)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectArtistAlbum(indexPath.item)
    }
}

extension ArtistDetailViewController: UICollectionViewDelegateFlowLayout { }

