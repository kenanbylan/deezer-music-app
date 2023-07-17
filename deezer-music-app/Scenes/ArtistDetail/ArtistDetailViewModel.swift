//
//  ArtistDetailViewModel.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 14.07.2023.
//

import Foundation

final class ArtistDetailViewModel: ArtistDetailViewModelProtocol {
    
    var delegate: ArtistDetailViewModelDelegate?
    var coordinator: ArtistDetailCoordinator?
    private let artistDetailService: ArtistDetailServiceProtocol

    var artistAlbumDetail: [AlbumTracksData] = []
    var selectArtist: ArtistListResponse?
    var selectArtistAlbumImage: URL?
    var albumId: Int?
    var albumData: AlbumData?
    
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
        albumId = self.artistAlbumDetail[index].album?.id
        getAlbumById(albumId: albumId ?? 0 )
        print("Album Detail", artistAlbumDetail[0].album?.tracklist)
    }
}

//MARK: - GET RESPONSE DATA

extension ArtistDetailViewModel {
    
    private func getArtistTracklist(tracklist: String) {
        artistDetailService.getArtistData(tracklist: tracklist) { [weak self] tracklists, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error:",error.localizedDescription)
                ///TODO: do alert handler.
            } else {
                // Aynı albüme sahip olanları filtrele
                let filteredAlbums = self.filterDuplicateAlbums(albums: tracklists?.data ?? [])
                self.artistAlbumDetail = filteredAlbums
                self.delegate?.handleVieModelOutput(.showArtistAlbum(filteredAlbums))
            }
        }
    }

    private func getAlbumById(albumId: Int) -> Void {
        artistDetailService.getAlbumById(albumId: albumId) { [weak self] albumData, error in
            if let error = error {
                print("Error :",error)
            } else {
                self?.coordinator?.showArtistAlbum(albumData: albumData!,artistAlbumDetail: self!.artistAlbumDetail)
            }
        }
    }
}

//MARK: Helper Function:

extension ArtistDetailViewModel {
    private func filterDuplicateAlbums(albums: [AlbumTracksData]) -> [AlbumTracksData] {
        var uniqueAlbums: [AlbumTracksData] = []
        var albumIds: Set<Int> = []
        
        for album in albums {
            guard let albumId = album.album?.id else { continue }
            
            if !albumIds.contains(albumId) {
                uniqueAlbums.append(album)
                albumIds.insert(albumId)
            }
        }
        return uniqueAlbums
    }
}


