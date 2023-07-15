//
//  ArtistDetailViewModel.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 14.07.2023.
//

import Foundation

class ArtistDetailViewModel: ArtistDetailViewModelProtocol {
    
    var delegate: ArtistDetailViewModelDelegate?
    var coordinator: ArtistDetailCoordinator?
    var artistAlbumDetail: [AlbumTracksData] = []
    
    private let artistDetailService: ArtistDetailServiceProtocol
    
    var selectArtist: ArtistListResponse?
    
    
    var selectArtistAlbumImage: URL?
    
    init(artistDetailService: ArtistDetailServiceProtocol) {
        self.artistDetailService = artistDetailService
    }
    
    func viewDidLoad() {
        delegate?.handleVieModelOutput(.showTitleImage(selectArtist?.pictureBig))
        delegate?.handleVieModelOutput(.showTitle(selectArtist?.name ?? "nil"))
        getArtistTracklist(tracklist: (selectArtist?.tracklist)!)
        
    }
    
    func artistAlbumAt(_ index: Int) -> AlbumTracksData? {
        guard index >= 0 && index < artistAlbumDetail.count else { return nil }
        return artistAlbumDetail[index]
    }
    
    func didSelectArtistAlbum(_ index: Int) {
        //TODO:
    }
}


//MARK: - GET RESPONSE DATA
extension ArtistDetailViewModel {
    
    //TODO: will be added 'getArtistDetail(artistId:)
    
    private func getArtistTracklist(tracklist: String) {
        artistDetailService.getArtistData(tracklist: tracklist) { [weak self] tracklists, error in
            guard let  self = self else { return }
            
            if let error = error {
                print("Error:",error.localizedDescription)
                ///TODO: do alert handler.
            } else {
                self.artistAlbumDetail = tracklists?.data ?? []
                self.delegate?.handleVieModelOutput(.showArtistAlbum(self.artistAlbumDetail))
                print("Select artist : ", self.selectArtist)
            }
        }
    }
}



