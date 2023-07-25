//
//  FavoriteCollectionViewCell.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 25.07.2023.

import UIKit
import Kingfisher

protocol FavoriteCollectionViewCellDelegate: AnyObject {
    func removeFromFavorite(id: Int)
}

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var deleteButton: UIButton!
    weak var delegate: FavoriteCollectionViewCellDelegate?
    var id: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func updateWith(favorites: AlbumDetailTrackListData) {
        
        self.artistNameLabel.text = favorites.artistName
        self.titleLabel.text = favorites.title
        guard let image = favorites.albumImage else { return }
        guard let url = URL(string: image) else { return }
        self.favoriteImageView.kf.setImage(with: url)
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        delegate?.removeFromFavorite(id: id)
    }
}

//MARK: SETUP-UI

extension FavoriteCollectionViewCell {
    private func setupUI() {
        
        favoriteImageView.layer.cornerRadius = 8.0
        favoriteImageView.clipsToBounds = true
        favoriteImageView.layer.shadowColor = UIColor.black.cgColor
        favoriteImageView.layer.shadowOpacity = 0.4
        favoriteImageView.layer.shadowOffset = CGSize(width: 2, height: 2)
        favoriteImageView.layer.shadowRadius = 4.0
    }
}

