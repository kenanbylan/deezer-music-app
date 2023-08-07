//  ArtistTrackViewModel.swift
//  deezer-music-app
//  Created by Kenan Baylan on 15.07.2023.

import Foundation

final class ArtistAlbumViewModel: ArtistAlbumViewModelProtocol {
    
    var coordinator: ArtistAlbumCoordinator?
    var delegate: ArtistAlbumViewModelDelegate?
    var miniBarDelegate: MiniBarDelegate? //MARK: - Will be change's
    
    private let albumTrackService: AlbumTrackServiceProtocol
    var artistAlbumDetail: [AlbumDetailTrackListData]?
    var selectAlbumId: Int?
    var selectedAlbumName: String?
    
    init(albumTrackService: AlbumTrackServiceProtocol) {
        self.albumTrackService = albumTrackService
    }
    
    func viewDidLoad() {
        self.delegate?.handleViewModelOutput(.showTitle(selectedAlbumName ?? "nil"))
        guard let selectAlbumId = selectAlbumId else { return }
        getAlbumById(albumId: selectAlbumId)
    }
    
    //MARK: For collectionView
    func numberOfAlbum() -> Int {
        return artistAlbumDetail?.count ?? 0
    }
    
    func albumDataAt(index: Int) -> AlbumDetailTrackListData? {
        guard index >= 0 && index < artistAlbumDetail?.count ?? 0 else { return nil }
        return artistAlbumDetail?[index]
    }
    
    func didSelectAlbumAt(index: Int) {
        let musicData = albumDataAt(index: index)
        guard let musicData = musicData else { return }
        miniBarDelegate?.playMusic(musicData: musicData)
    }
}

//MARK: Core-Data Function

extension ArtistAlbumViewModel {
    
    func favoriteAlbum(selectTrackId: Int) {
        if let selectAlbum = artistAlbumDetail?.first(where: { $0.trackId == selectTrackId }) {
            CoreDataManager.shared.addFavoriteTrack(data: selectAlbum) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure(let error):
                    self.delegate?.handleViewModelOutput(.showError(errorDescription: error.localizedDescription))
                case .success(_):
                    self.delegate?.handleViewModelOutput(.succesAddFavorite(true))
                }
            }
        } else {
            print("Album data is nil or not found.")
        }
    }
    
    func removeFavoriteAlbum(selectTrackId: Int) {
        CoreDataManager.shared.removeFavoriteTrack(id: selectTrackId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.delegate?.handleViewModelOutput(.showError(errorDescription: error.localizedDescription))
            case .success(_):
                self.delegate?.handleViewModelOutput(.succesAddFavorite(false))
            }
        }
    }
}

//MARK: - API GET response

extension ArtistAlbumViewModel {
    private func getAlbumById(albumId: Int) {
        albumTrackService.getAlbumTrack(albumId: albumId) { [weak self] albumDetail, error in
            guard let self = self else { return }
            guard let albumDetail = albumDetail else { return }
            
            if let error = error {
                delegate?.handleViewModelOutput(.showError(errorDescription: error.localizedDescription))
            } else {
                self.artistAlbumDetail = albumDetail.tracks?.data?.map({
                    AlbumDetailTrackListData(
                        id: Int64(albumDetail.id),
                        albumImage: albumDetail.coverMedium,
                        trackId: $0.id,
                        title: $0.title,
                        duration: $0.duration,
                        preview: $0.preview,
                        artistName: albumDetail.artist?.name,
                        albumName: albumDetail.artist?.name,
                        link: $0.link
                    )
                })
                self.delegate?.handleViewModelOutput(.showArtistAlbumList(self.artistAlbumDetail!))
            }
        }
    }
}
