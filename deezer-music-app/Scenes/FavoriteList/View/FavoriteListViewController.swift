//
//  FavoriteListViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 17.07.2023.
//

import UIKit
import Lottie


final class FavoriteListViewController: UIViewController {
    
    private let refreshControl = UIRefreshControl()
    private var animationView: LottieAnimationView?
    
    
    var viewModel: FavoriteListViewModelProtocol! {
        didSet { viewModel.delegate = self }
    }
    
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupCollectionView()
        setupRefreshControl()
        showEmptyStateAnimationIfNeeded()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.viewDidLoad()
        self.setupRefreshControl()
        self.showEmptyStateAnimationIfNeeded()
    }
}


//MARK: helper func.
extension FavoriteListViewController {
    
    private func setupCollectionView() {
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.register(ArtistAlbumCollectionViewCell.self)
    }
    
    private func setupRefreshControl() {
        favoriteCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc private func refreshData() {
        // Tabloyu yenileme işlemlerini burada yapabilirsiniz.
        viewModel.viewDidLoad()
        favoriteCollectionView.reloadData()
        refreshControl.endRefreshing()
    }
}




extension FavoriteListViewController: FavoriteListViewModelDelegate {
    func handleViewModelOutput(_ output: FavoriteListViewModelOutput) {
        
        switch output {
        case .showFavoriteList(_):
            favoriteCollectionView.reloadData()
            showEmptyStateAnimationIfNeeded()
            
        case .setTitle(let title):
            self.navigationItem.title = title
        case .setLoading(_):
            break
        case .successRemoved(_):
            favoriteCollectionView.reloadData()
            showEmptyStateAnimationIfNeeded()
        }
    }
}

extension FavoriteListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfFavorites()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = CollectionCellIdentifier.artistAlbumCell.rawValue
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? ArtistAlbumCollectionViewCell
        
        
        cell?.delegate = self
        
        if let favoriteData = viewModel.favoriteAt(index: indexPath.item) {
            cell?.id = Int(favoriteData.id)
            cell?.updateUIWith(albumData: favoriteData)
        }
        
        return cell ?? UICollectionViewCell()
    }
}

extension FavoriteListViewController: UICollectionViewDelegate { }

extension FavoriteListViewController: ArtistAlbumCollectionViewCellDelegate {
    func favoriteImageViewTapped(id: Int, isFavorite: Bool) {
        if isFavorite {
            viewModel.removeFavoriteById(selectTrackId: id)
        } else {
            print("id: \(id) is not favorite")
        }
    }
}


//MARK: Lottie animation setup.

extension FavoriteListViewController {
    
    private func showEmptyStateAnimationIfNeeded() {
        if viewModel.numberOfFavorites() == 0 {
            if animationView == nil {
                
                animationView = LottieAnimationView(name: "test-lottie")
                animationView?.translatesAutoresizingMaskIntoConstraints = false
                animationView?.loopMode = .loop
                animationView?.contentMode = .scaleAspectFit
                view.addSubview(animationView!)
                animationView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                animationView?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
                animationView?.widthAnchor.constraint(equalToConstant: 300).isActive = true
                animationView?.heightAnchor.constraint(equalToConstant: 300).isActive = true
            }
            animationView?.play()
            favoriteCollectionView.isHidden = true
        } else {
            animationView?.stop()
            favoriteCollectionView.isHidden = false
        }
    }
    
}
