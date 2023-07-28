//
//  CategoryCollectionViewCell.swift
//  deezer-music-app
//  Created by Kenan Baylan on 10.07.2023.


import UIKit
import Kingfisher

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var categoryTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        layer.cornerRadius = 12
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 12.0
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        //layer.shouldRasterize = true
    }

    public func updateUIWith(genre: GenreResponse) {
        categoryTitle.text = genre.name
        categoryImageView.kf.setImage(with: genre.pictureMedium)
    }
    
    public func updateUIWith(artist: ArtistListResponse) {
        categoryTitle.text = artist.name
        categoryImageView.kf.setImage(with: artist.pictureMedium)
    }
}
