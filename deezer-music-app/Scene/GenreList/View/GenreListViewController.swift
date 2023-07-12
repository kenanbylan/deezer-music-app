//
//  MusicListViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 10.07.2023.

import UIKit


final class GenreListViewController: UIViewController, Storyboarded {
    
    @IBOutlet private weak var genreCollectionView: UICollectionView!
    weak var coordinator: GenreListCoordinator?
    
    private var genreList: [GenreResponse] = []
    
    var viewModel: GenreListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        case .showGenreList(let genres):
            
            self.genreList = genres
            self.genreCollectionView.reloadData()
        }
    }
    
}

// MARK: - UICollectionViewDataSource

extension GenreListViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genreList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCollectionViewCell.self) , for: indexPath) as! CategoryCollectionViewCell
        
        cell.setupConfig(genre: genreList[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: will be code
    }
}

// MARK: - UICollectionViewDelegate

extension GenreListViewController: UICollectionViewDelegate {
    //TODO: will be writes
}
