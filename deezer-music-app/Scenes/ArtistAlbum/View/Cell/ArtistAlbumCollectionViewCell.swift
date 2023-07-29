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

class ArtistAlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    weak var delegate: ArtistAlbumCollectionViewCellDelegate?
    
    var isFavorite: Bool = false
    var musicId: Int = 0
    
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
        favoriteImageView.image = isFavorite ? UIImage(named: "lover") : UIImage(named: "heart")
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
        favoriteImageView.image = isFavorite ? UIImage(named: "lover") : UIImage(named: "heart")
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
