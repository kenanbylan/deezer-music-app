//
//  MusicDetailViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 24.07.2023.
//

import UIKit
import AVFoundation

final class MusicDetailViewController: UIViewController {
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var trackDuration: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var titlePage: UILabel!
    
    var viewModel: MusicDetailViewModel! { didSet { viewModel.delegate = self } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func playButtonClicked(_ sender: Any) { viewModel.togglePlayback() }
    @IBAction func shareButtonTapped(_ sender: Any) { viewModel.shareTrack() }
    
}

extension MusicDetailViewController: MusicDetailViewModelDelegate {
    
    func setTitle(_ title: String) { trackTitleLabel.text = title }
    func setArtist(_ artist: String) { trackDuration.text = artist }
    func setAlbumTitle(_ albumTitle: String) { titlePage.text = albumTitle }
    func setPlayButtonImage(_ image: UIImage) { playButton.setImage(image, for: .normal) }
    
    func setAlbumImage(_ imageURL: URL?) {
        if let imageURL = imageURL {
            trackImageView.kf.setImage(with: imageURL)
        }
    }
}

extension MusicDetailViewController {
    private func setupUI() {
        trackImageView.contentMode = .scaleAspectFill
        trackImageView.layer.cornerRadius = 12
    }
}


