//
//  MusicListViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 10.07.2023.

import UIKit

final class GenreListViewController: UIViewController {
    
    @IBOutlet private weak var genreCollectionView: UICollectionView!
    weak var coordinator: GenreListCoordinator?
    var viewModel: GenreListViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genreCollectionView.delegate = self
        
        viewModel.delegate = self
        viewModel?.viewDidLoad()
        registerCollectionView()
    }
    
    private func registerCollectionView() {
        genreCollectionView.register(CategoryCollectionViewCell.self)
    }
}

extension GenreListViewController : GenreListViewModelDelegate {
    func handleViewModelOutput(_ output: GenreListViewModelOutput) {
        switch output {
        case .setLoading(_):
            break
        case .showGenreList(_):
            self.genreCollectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension GenreListViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfGenres()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCollectionViewCell.self) , for: indexPath) as! CategoryCollectionViewCell
        
        if let genre = viewModel.genreAtIndex(indexPath.item) {
            cell.setupConfig(genre: genre)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected index : ",indexPath)
        viewModel.didSelectGenreAtIndex(indexPath.item)
    }
}


extension GenreListViewController: UICollectionViewDelegateFlowLayout {
    
}
