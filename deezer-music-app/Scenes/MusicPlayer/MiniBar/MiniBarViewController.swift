//
//  MusicBarViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 24.07.2023.
//

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
        
        guard let previewURLString = musicData.preview, let previewURL = URL(string: previewURLString) else { return }
        startMusic(url: previewURL)
    }
    
    private func startMusic(url: URL) {
        stopMusic()
        
        audioPlayer = AVPlayer(url: url)
        audioPlayer?.play()
        isPlaying = true
    }
    
     func stopMusic() {
        if isPlaying {
            audioPlayer?.pause()
            isPlaying = false
        }
    }
    
    @IBAction func musicPauseButtonTapped(_ sender: Any) {
        
        if isPlaying {
            musicPauseButtonTapped.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            stopMusic()
            
        } else {
            musicPauseButtonTapped.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            guard let previewURLString = musicData?.preview, let previewURL = URL(string: previewURLString) else { return }
            startMusic(url: previewURL)
        }
    }
    
    @objc func tapDetected() {
        guard let delegate = delegate else { return }
        guard let musicData = musicData else { return }
        delegate.showMusicDetailPage(selectMusicData: musicData)
    }
}


//MARK: SETUP - UI
extension MiniBarViewController {
    
    private func setupGestureTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
    }
    
    private func setupUI() { }
    
}
