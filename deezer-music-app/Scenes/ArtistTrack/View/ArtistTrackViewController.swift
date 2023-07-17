//
//  ArtistTrackViewController.swift
//  deezer-music-app

//  Created by Kenan Baylan on 15.07.2023.

import UIKit
import AVFAudio

final class ArtistTrackViewController: UIViewController {
    @IBOutlet private weak var artistTrackCollectionView: UICollectionView!
    private weak var coordinator: ArtistTrackCoordinator?
    var viewModel: ArtistTrackViewModelProtocol! {
        didSet {
            viewModel.delegate  = self
        }
    }
    
    var audioPlayer:AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artistTrackCollectionView.delegate = self
        artistTrackCollectionView.dataSource = self
        
        viewModel.viewDidLoad()
        artistTrackCollectionView.register(ArtistTrackCollectionViewCell.self)
    }
}

//MARK: ArtistTrackViewModelDelegate

extension ArtistTrackViewController: ArtistTrackViewModelDelegate {
    func handleViewModelOutput(_ output: ArtistTrackViewModelOutput) {
        switch output {
        case .showTitle(let title):
            self.navigationItem.title = title
            
        case .showArtistTrackList(_):
            artistTrackCollectionView.reloadData()
        case .setLoading(_ ):
            break
            
        case .setLoading(_):
            break
            
        case .didSelectTrack(let trackData):
            playTrack(track: trackData)
        }
    }
}

//MARK: UICollectionViewDataSource

extension ArtistTrackViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfTracks()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: ArtistTrackCollectionViewCell.self),
            for: indexPath) as! ArtistTrackCollectionViewCell
        
        //FİXED: From time to time the application crashes when the application starts.
        if let trackData = viewModel.trackDataAt(index: indexPath.item) {
            let albumImage = viewModel.artistAlbumDetail?[indexPath.item].album?.coverMedium
            cell.updateUIWith(trackData: trackData,albumImage: albumImage!)
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectTrackAt(indexPath.item)
        
    }
}

extension ArtistTrackViewController: UICollectionViewDelegate { }

//MARK: For audio player

extension ArtistTrackViewController {
    private func playTrack(track: Track) {
        print("Track: ",track )
    }
}
