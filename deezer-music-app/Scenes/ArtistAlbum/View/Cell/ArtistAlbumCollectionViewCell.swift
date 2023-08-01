//
//  ArtistAlbumCollectionViewCell.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 17.07.2023.
//

import UIKit
import Kingfisher

protocol ArtistAlbumCollectionViewCellDelegate: AnyObject {
    func favoriteImageViewTapped(id: Int, isFavorite: Bool)
}

final class ArtistAlbumCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    @IBOutlet private weak var trackImageView: UIImageView!
    @IBOutlet private weak var trackTitle: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var favoriteImageView: UIImageView!
    
    //MARK: - Variable's
    private var isFavorite: Bool = false
    private var musicId: Int = 0
    
    //MARK: - Delegate
    weak var delegate: ArtistAlbumCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        tapGesture()
    }
    
    func updateUIWith(albumData: AlbumDetailTrackListData) {
        guard let trackId = albumData.trackId else { return }
        self.musicId = trackId
        self.isFavorite = CoreDataManager.shared.isTrackFavorite(id: Int64(musicId))
        
        self.trackTitle.text = albumData.title
        self.durationLabel.text = (albumData.duration?.formatDuration() ?? "")
        
        guard let image = albumData.albumImage else { return }
        guard let url = URL(string: image) else { return }
        
        trackImageView.kf.setImage(with: url)
        favoriteImageView.image = isFavorite ? UIImage(named: Constants.Image.active_fav) : UIImage(named: Constants.Image.inactive_fav)
    }
}

//MARK: Tap gesture and clicked imageView
extension ArtistAlbumCollectionViewCell {
    
    private func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(favoriteImageViewTapped))
        favoriteImageView.isUserInteractionEnabled = true
        favoriteImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func favoriteImageViewTapped() {
        isFavorite.toggle() //MARK: inpect
        favoriteImageView.image = isFavorite ? UIImage(named: Constants.Image.active_fav) : UIImage(named: Constants.Image.inactive_fav)
        delegate?.favoriteImageViewTapped(id: musicId, isFavorite: isFavorite)
    }
}

//MARK: SETUP-UI

extension ArtistAlbumCollectionViewCell {
    private func setupUI() {
        
        layer.borderColor = UIColor.systemGray.cgColor
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
        clipsToBounds = true
        
        trackImageView.contentMode = .scaleAspectFit
        trackImageView.layer.borderWidth = 2
        trackImageView.layer.cornerRadius = 12
        trackImageView.layer.borderColor = UIColor.systemGray.cgColor
    }
}
