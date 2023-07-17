//
//  ArtistTrackViewModel.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 15.07.2023.
//

import Foundation

final class ArtistTrackViewModel: ArtistTrackViewModelProtocol {
    var coordinator: ArtistTrackCoordinator?
    var delegate: ArtistTrackViewModelDelegate?
    private let artistTrackService: AlbumTrackServiceProtocol
    
    var artistAlbumData: AlbumData?
    var artistAlbumDetail: [AlbumTracksData]?
    
    init(artistTrackService: AlbumTrackServiceProtocol) {
        self.artistTrackService = artistTrackService
    }
    
    func viewDidLoad() {
        self.delegate?.handleViewModelOutput(.showTitle(self.artistAlbumData?.title ?? "nil"))
    }
    
    func numberOfTracks() -> Int {
        return artistAlbumData?.tracks?.data.count ?? 0
    }
    
    func trackDataAt(index: Int) -> Track? {
        guard index >= 0, let tracks = artistAlbumData?.tracks, index < tracks.data.count else { return nil }
        return tracks.data[index]
    }
    
    func didSelectTrackAt(_ index: Int) {
        guard let trackData = trackDataAt(index: index) else { return }
        print("Track data:",trackData)
        self.delegate?.handleViewModelOutput(.didSelectTrack(trackData))
    }
}

//MARK: - GET RESPONSE DATA

extension ArtistTrackViewModel { }
