//
//  MusicBarViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 24.07.2023.

import UIKit
import Kingfisher
import AVFoundation

var audioPlayer: AVPlayer?

protocol MiniBarDelegate {
    func showMusicDetailPage(selectMusicData: AlbumDetailTrackListData)
    func miniBarDidTapButton()
    func playMusic(musicData: AlbumDetailTrackListData)
    func stopMusic()
}

final class MiniBarViewController: UIViewController {
    
    //MARK: Property's
    @IBOutlet private weak var musicImageView: UIImageView!
    @IBOutlet private weak var musicTitle: UILabel!
    @IBOutlet weak var musicPauseButtonTapped: UIButton!
    
    //MARK: Variable's
    var delegate: MiniBarDelegate?
    var musicData: AlbumDetailTrackListData?
    var isPlaying: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGestureTap()
    }
    
    func updateMusicWith(musicData: AlbumDetailTrackListData) {
        self.musicTitle.text = musicData.title
        self.musicData = musicData
        let url = URL(string: musicData.albumImage!)
        guard let url = url else { return }
        
        self.musicImageView.kf.setImage(with: url)
        
        if isPlaying {
            pause()
        } else {
            playMusic()
        }
        updatePlayPauseButtonImage()
    }
    
    private func playMusic() {
        guard let previewURLString = musicData?.preview, let previewURL = URL(string: previewURLString) else { return }
        MusicPlayer.shared.play(url: previewURL)
    }
    
    private func stopMusic() {
        MusicPlayer.shared.pause()
    }
    
    @IBAction func musicPauseButtonTapped(_ sender: Any) {
        if MusicPlayer.shared.isPlaying {
            stopMusic()
        } else {
            playMusic()
        }
        updatePlayPauseButtonImage()
    }
    
    @objc func tapDetected() {
        guard let delegate = delegate else { return }
        guard let musicData = musicData else { return }
        delegate.showMusicDetailPage(selectMusicData: musicData)
    }
}

//MARK: SETUP - UI
extension MiniBarViewController {
    
    private func updatePlayPauseButtonImage() {
        let buttonImage = MusicPlayer.shared.isPlaying ? UIImage(systemName: "pause.circle.fill") : UIImage(systemName: "play.circle.fill")
        musicPauseButtonTapped.setImage(buttonImage, for: .normal)
    }
    
    private func setupGestureTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
    }
    
    private func setupUI() {
        musicImageView.contentMode = .scaleAspectFit
        musicImageView.layer.borderWidth = 2
        musicImageView.layer.cornerRadius = 12
        musicImageView.layer.borderColor = UIColor.systemGray.cgColor
    }
}
