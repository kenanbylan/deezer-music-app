import UIKit

class GenreListViewModel: GenreListViewModelProtocol {
    
    
    
    var delegate: GenreListViewModelDelegate?
    private let service: GenreListServiceProtocol
    var genreItems: [GenreResponse] = []
    var coordinator: GenreListCoordinator?
    
    init(service: GenreListServiceProtocol) {
        self.service = service
    }
    
    func viewDidLoad() {
        delegate?.handleViewModelOutput(.setLoading(true))
        delegate?.handleViewModelOutput(.setTitle("Deezer Musics"))
        getGenre()
    }
    
    var numberOfGenres: Int {
        return genreItems.count
    }
    
    func genreAt(_ index: Int) -> GenreResponse? {
        guard index >= 0 && index < genreItems.count else {
            return nil
        }
        return genreItems[index]
    }
    
    func didSelectGenreAt(_ index: Int) {
        print("Clicked index:", index)
        guard let genre = self[index] else {
            return
        }
        // TODO: Handle genre selection
        guard let coordinator = coordinator else {
            return
        }
        
        coordinator.showArtistList(genreId: genre.id ?? 0)
    }
}

//MARK: Get endpoint services

extension GenreListViewModel {
    
    private func getGenre() {
        service.getGenre { [weak self] genres, error in
            guard let self = self else { return }
            if let error = error {
                print("Error", error.localizedDescription)
            } else {
                self.genreItems = genres?.data ?? []
                self.delegate?.handleViewModelOutput(.setLoading(false))
                self.delegate?.handleViewModelOutput(.showGenreList(self.genreItems))
            }
        }
    }
}

