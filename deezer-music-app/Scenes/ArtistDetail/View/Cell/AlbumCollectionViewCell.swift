//
//  AlbumCollectionViewCell.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 14.07.2023.
//

import UIKit
import Kingfisher

final class AlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var albumImageView: UIImageView!
    @IBOutlet private weak var albumNameLabel: UILabel!
    @IBOutlet private weak var albumReleaseDataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    public func updateUIWith(artistAlbum: AlbumResponse) {
        let coverURL = URL(string: artistAlbum.coverMedium ?? "")
        self.albumImageView.kf.setImage(with: coverURL)
        self.albumNameLabel.text = artistAlbum.title
        self.albumReleaseDataLabel.text = artistAlbum.releaseDate?.formatReleaseDate() ?? ""
    }
}

//MARK: AlbumCollectionViewCell Setup UI
extension AlbumCollectionViewCell {
    
    private func setupUI() {
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
        clipsToBounds = true
        
        albumImageView.contentMode = .scaleAspectFill
        albumImageView.layer.borderWidth = 2
        albumImageView.layer.borderColor = UIColor.systemGray.cgColor
        albumImageView.layer.cornerRadius = 12
    }
}
