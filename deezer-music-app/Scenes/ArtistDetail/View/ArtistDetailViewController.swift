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
    private var loadIndicator: UIActivityIndicatorView!
    
    var viewModel: ArtistDetailViewModelProtocol! {
        didSet {
            viewModel.delegate  = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        registerCollectionView()
        settingViewControllerUI()
    }
    
    private func registerCollectionView() {
        artistDetailCollectionView.delegate = self
        artistDetailCollectionView.dataSource = self
        artistDetailCollectionView.register(AlbumCollectionViewCell.self)
    }
}

//MARK: ArtistDetailViewModelDelegate

extension ArtistDetailViewController : ArtistDetailViewModelDelegate {
    func handleVieModelOutput(_ output: ArtistDetailViewModelOutput) {
        switch output {
            
        case .setLoading(let isLoad):
            DispatchQueue.main.async { [self] in
                isLoad ? self.loadIndicator.startAnimating() : self.loadIndicator.stopAnimating()
            }
        case .showArtistAlbum(_):
            self.artistDetailCollectionView.reloadData()
            
        case .showTitle(let title):
            self.navigationItem.title = title
            
        case .showError(errorDescription: let error):
            self.presentErrorAlert(title: "Error" , message: error)
        }
    }
}

extension ArtistDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.artistAlbums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: AlbumCollectionViewCell.self),
            for: indexPath) as! AlbumCollectionViewCell
        
        if let albumData = viewModel.artistAlbumAt(indexPath.item) {
            cell.updateUIWith(artistAlbum: albumData )
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
        if let image = viewModel.selectedArtistHeaderImage {
            headerView.updateWith(image: image)
        }
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectArtistAlbum(indexPath.item)
    }
}

extension ArtistDetailViewController: UICollectionViewDelegateFlowLayout { }

extension ArtistDetailViewController {
    func settingViewControllerUI() {
        loadIndicator = UIActivityIndicatorView()
        self.view.addSubview(loadIndicator)
        loadIndicator.center = self.view.center
        loadIndicator.hidesWhenStopped = true
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }
}
