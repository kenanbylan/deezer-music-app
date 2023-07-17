//
//  ArtistTrackCollectionViewCell.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 17.07.2023.
//

import UIKit
import Kingfisher

class ArtistTrackCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    public func updateUIWith(trackData: Track, albumImage: String) {
        self.trackTitle.text = trackData.title
        self.durationLabel.text = trackData.formattedDuration
        
        if let coverURL = URL(string: albumImage) {
            self.trackImageView.kf.setImage(with: coverURL)
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
        
        trackImageView.contentMode = .scaleAspectFill
        trackImageView.layer.borderWidth = 2
        trackImageView.layer.borderColor = UIColor.systemGray.cgColor
    }
}
