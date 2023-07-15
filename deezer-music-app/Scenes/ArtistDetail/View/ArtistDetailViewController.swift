//
//  ArtistDetailViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 14.07.2023.
//

import UIKit
import Kingfisher

class ArtistDetailViewController: UIViewController {

    @IBOutlet private weak var artistDetailCollectionView: UICollectionView!
    @IBOutlet private weak var artistImageView: UIImageView!
    private weak var coordinator: ArtistDetailCoordinator?

    var viewModel: ArtistDetailViewModelProtocol! {
        didSet {
            viewModel.delegate  = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        artistDetailCollectionView.delegate = self
        artistDetailCollectionView.dataSource = self
        artistDetailCollectionView.register(AlbumCollectionViewCell.self)
        setupUI()
    }
}
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
            self.artistImageView.kf.setImage(with: image)
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
}

extension ArtistDetailViewController: UICollectionViewDelegateFlowLayout {
}


//MARK: - ImageView SetupUI
extension ArtistDetailViewController {
    private func setupUI() {
        artistImageView.layer.cornerRadius = 12
        artistImageView.layer.shadowColor = UIColor.black.cgColor
        artistImageView.layer.shadowOpacity = 2.0
        artistImageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        artistImageView.layer.shadowRadius = 4
        artistImageView.layer.masksToBounds = false
        artistImageView.contentMode = .scaleAspectFill
        artistImageView.clipsToBounds = true
    }
}

