//
//  MusicDetailViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 24.07.2023.
//

import UIKit

final class MusicDetailViewController: UIViewController {
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var trackArtistLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var titlePage: UILabel!
    
    lazy var miniBar: MiniBarViewController = {
        let storyboard = UIStoryboard(name: "MiniBar", bundle: nil)
        guard let miniBar = storyboard.instantiateViewController(withIdentifier: "MiniBarViewController") as? MiniBarViewController else {
            fatalError("MiniBarViewController not found in the storyboard.")
        }
        miniBar.view.translatesAutoresizingMaskIntoConstraints = false
        return miniBar
    }()
    
    
    var viewModel: MusicDetailViewModelProtocol! {
        didSet { viewModel.delegate = self }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        miniBar.delegate = self
        viewModel.viewDidLoad()
    }
    
    @IBAction func playButtonClicked(_ sender: Any) {
        print("Play button clicked.")
        
        viewModel.togglePlayback()
        
        if viewModel.isMusicPlaying {
            guard let selectMusic = viewModel.selectPlayingMusic else { return }
            playMusic(musicData: selectMusic)
//            miniBar.delegate?.playMusic(musicData: selectMusic)
        } else {
            stopMusic()
//            miniBar.delegate?.stopMusic()
        }
        
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        viewModel.shareTrack()
    }
    
}

extension MusicDetailViewController: MusicDetailViewModelDelegate {
    
    func handleViewModelOutput(_ output: MusicDetailViewModelOutput) {
        switch output {
        case .setTitle(let title):
            trackTitleLabel.text = title
        case .setArtist(let artist):
            trackArtistLabel.text = artist
        case .setAlbumImage(let imageURL):
            trackImageView.kf.setImage(with: imageURL)
        case .setPlayButtonImage(let image):
            playButton.setImage(image, for: .normal)
        case .showLinkCopiedMessage(_):
            self.showAlertMessage(title: "Copy Link", message: "The link has been copied to the clipboard")
        case .setAlbumTitle(albumTitle: let albumTitle):
            titlePage.text = albumTitle
        }
    }
}


extension MusicDetailViewController : MiniBarDelegate {
    
    func showMusicDetailPage(selectMusicData: AlbumDetailTrackListData) {
        
    }
    
    func miniBarDidTapButton() {
        
    }
    
    func playMusic(musicData: AlbumDetailTrackListData) {
        miniBar.updateMusicWith(musicData: musicData)
    }
    
    func stopMusic() {
        miniBar.stopMusic()
    }
    
}
