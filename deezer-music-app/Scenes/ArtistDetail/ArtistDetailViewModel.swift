//
//  ArtistDetailViewModel.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 14.07.2023.

import Foundation

final class ArtistDetailViewModel: ArtistDetailViewModelProtocol {
    
    var delegate: ArtistDetailViewModelDelegate?
    var coordinator: ArtistDetailCoordinator?
    private let artistDetailService: ArtistDetailServiceProtocol
    
    //MARK: - new property
    var artistAlbums: [AlbumResponse] = []
    var artistDetail: ArtistResponse?
    var selectArtist: ArtistListResponse?
    var selectedArtistHeaderImage: String?
    
    init(artistDetailService: ArtistDetailServiceProtocol) {
        self.artistDetailService = artistDetailService
    }
    
    func viewDidLoad() {
        delegate?.handleVieModelOutput(.setLoading(true))
        guard let artistId = selectArtist?.id else { return }
        getArtistDetail(artistId: artistId)
    }
    
    func artistAlbumAt(_ index: Int) -> AlbumResponse? {
        guard index >= 0 && index < artistAlbums.count else { return nil }
        return artistAlbums[index]
    }
    
    func didSelectArtistAlbum(_ index: Int) {
        guard let album = artistAlbumAt(index) else { return }
        print("Seçilen album bilgileri : ", album)
        self.coordinator?.showArtistAlbum(albumId: album.id, albumName: album.title ?? "")
    }
}

//MARK: - GET RESPONSE DATA

extension ArtistDetailViewModel {
    private func getArtistDetail(artistId: Int) {
        delegate?.handleVieModelOutput(.setLoading(true))
        artistDetailService.getArtistDetail(artistId: artistId) { [weak self] artistDetail, error in
            if let error = error {
                self?.delegate?.handleVieModelOutput(.showError(errorDescription: error.localizedDescription))
            } else {
                guard let artistDetail = artistDetail else { return }
                self?.artistDetail = artistDetail
                self?.delegate?.handleVieModelOutput(.showTitle(self?.artistDetail?.name ?? "nil"))
                self?.selectedArtistHeaderImage = artistDetail.pictureBig ?? ""
            }
        }
        getAlbumById(artistId: artistId)
        delegate?.handleVieModelOutput(.setLoading(false))
    }
    
    private func getAlbumById(artistId: Int) -> Void {
        delegate?.handleVieModelOutput(.setLoading(true))
        artistDetailService.getAlbumById(artistId: artistId) { [weak self] albumData, error in
            guard let self = self else { return }
            guard let albumData = albumData else { return }
            if let error = error {
                self.delegate?.handleVieModelOutput(.showError(errorDescription: error.localizedDescription))
            } else {
                self.artistAlbums = (albumData.data)!
                self.delegate?.handleVieModelOutput(.showArtistAlbum(self.artistAlbums))
            }
        }
        delegate?.handleVieModelOutput(.setLoading(false))
    }
}
