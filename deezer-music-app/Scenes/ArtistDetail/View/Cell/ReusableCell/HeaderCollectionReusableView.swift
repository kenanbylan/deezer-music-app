//
//  HeaderCollectionReusableView.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 15.07.2023.
//

import UIKit
import Kingfisher

class HeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var artistAlbumImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func updateWith(image: String) {
        guard let url = URL(string: image) else { return }
        artistAlbumImageView.kf.setImage(with: url)
    }
}

extension HeaderCollectionReusableView {
    
    private func setupUI() {
        artistAlbumImageView.contentMode = .scaleAspectFill
        artistAlbumImageView.layer.cornerRadius = 12
        artistAlbumImageView.layer.shadowColor = UIColor.black.cgColor
        artistAlbumImageView.layer.shadowOpacity = 2.0
        artistAlbumImageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        artistAlbumImageView.layer.shadowRadius = 4
        artistAlbumImageView.layer.masksToBounds = false
        artistAlbumImageView.contentMode = .scaleAspectFill
        artistAlbumImageView.clipsToBounds = true
    }
}
