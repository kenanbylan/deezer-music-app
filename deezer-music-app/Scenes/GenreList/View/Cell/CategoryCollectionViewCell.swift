//
//  CategoryCollectionViewCell.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 10.07.2023.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    
    private func configUI() {
        layer.cornerRadius = 12
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 2.0
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }

    public func setupConfig(genre: GenreResponse) {
        categoryTitle.text = genre.name
        categoryImageView.kf.setImage(with: genre.pictureMedium)
    }
    
    
    public func setupArtistConfig(artist: ArtistResponse) {
        categoryTitle.text = artist.name
        categoryImageView.kf.setImage(with: artist.pictureMedium)
    }

}
