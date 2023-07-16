//
//  AlbumCollectionViewCell.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 14.07.2023.
//

import UIKit
import Kingfisher

//TODO: will be Favorite image add
final class AlbumCollectionViewCell: UICollectionViewCell {
    
    //TODO: will be do private property
    @IBOutlet private weak var albumImageView: UIImageView!
    @IBOutlet private weak var albumNameLabel: UILabel!
    @IBOutlet private weak var albumReleaseDataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    public func updateUIWith(artistAlbum: AlbumTracksData) {
        if let coverURLString = artistAlbum.album?.coverMedium,
           let coverURL = URL(string: coverURLString) {
            self.albumImageView.kf.setImage(with: coverURL)
        }
        self.albumNameLabel.text = artistAlbum.album?.title
        //TODO: will be change.
        self.albumReleaseDataLabel.text = "22.03.2023"
    }
    
    public func updateUIWith(trackData: Track, albumImage: String) {
        self.albumNameLabel.text = trackData.title
        self.albumReleaseDataLabel.text = trackData.formattedDuration
        
        if let coverURL = URL(string: albumImage) {
            self.albumImageView.kf.setImage(with: coverURL)
        }
    }
    
    private func setupUI() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray.cgColor
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
        clipsToBounds = true
        
        albumImageView.contentMode = .scaleAspectFill
        albumImageView.layer.borderWidth = 2
        albumImageView.layer.borderColor = UIColor.systemGray.cgColor
    }
    
}
