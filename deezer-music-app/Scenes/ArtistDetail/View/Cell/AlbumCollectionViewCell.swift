//
//  AlbumCollectionViewCell.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 14.07.2023.
//

import UIKit
import Kingfisher

class AlbumCollectionViewCell: UICollectionViewCell {
    
    //TODO: will be do private property
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumReleaseDataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    //TODO: fix the code here.
    public func updateUIWith(artistAlbum: AlbumTracksData) {
        if let coverURLString = artistAlbum.album?.coverMedium,
           let coverURL = URL(string: coverURLString) {
            self.albumImageView.kf.setImage(with: coverURL)
        }
        self.albumNameLabel.text = artistAlbum.album?.title
        
        //TODO: will be change.
        self.albumReleaseDataLabel.text = "22.03.2023"
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
