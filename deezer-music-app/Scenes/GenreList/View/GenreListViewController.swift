//
//  MusicListViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 10.07.2023.

import UIKit

final class GenreListViewController: UIViewController {
    @IBOutlet private weak var genreCollectionView: UICollectionView! {
        didSet {
            genreCollectionView.delegate = self
            genreCollectionView.dataSource = self
        }
    }
    var viewModel: GenreListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.viewDidLoad()
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
        case .setTitle(let title):
            self.navigationController?.title = title
        }
    }
}

// MARK: - UICollectionViewDataSource

extension GenreListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfGenres
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: CategoryCollectionViewCell.self),
            for: indexPath) as! CategoryCollectionViewCell
        
        if let genre = viewModel.genreAt(indexPath.item) {
            cell.updateUIWith(genre: genre)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectGenreAt(indexPath.item)
    }
}

extension GenreListViewController: UICollectionViewDelegateFlowLayout { }

