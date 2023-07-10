//
//  MusicListViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 10.07.2023.
//

import UIKit

class MusicListViewController: UIViewController {
    
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    let viewModel = MusicListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        returnViewModel()
        registerCollectionView()
        
    }
    
    private func returnViewModel() {
        DispatchQueue.main.async {
            self.viewModel.getGenres()
        }
        
        viewModel.successCallback = { [weak self] in
            self?.genreCollectionView.reloadData()
        }
        
        viewModel.errorCallback = { errorMessage in
            //TODO: Will be alert added.
        }
        
    }
    
    private func registerCollectionView() {
        genreCollectionView.register(CategoryCollectionViewCell.self)
    }
    
}


extension MusicListViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.genreItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let reuseIdentifier = CategoryCollectionViewCell.identifier
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCollectionViewCell.self) , for: indexPath) as! CategoryCollectionViewCell
        
        if viewModel.genreItems != nil {
            cell.setupConfig(genre: viewModel.genreItems[indexPath.row])
        }
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedGenre = viewModel.genreItems[indexPath.row]
        let artistId = 2
        
        let musicListCoordinator = MusicListCoordinator(navigationController: navigationController!)
        
        musicListCoordinator.showArtist(artistId: artistId)
    }
    
    
    
    
}
