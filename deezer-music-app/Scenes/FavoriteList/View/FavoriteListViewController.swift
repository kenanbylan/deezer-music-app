//
//  FavoriteListViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 17.07.2023.

import UIKit
import Lottie


final class FavoriteListViewController: UIViewController {
    
    private var animationView: LottieAnimationView?
    private let refreshControl = UIRefreshControl()
    @IBOutlet private weak var favoriteCollectionView: UICollectionView!
    var viewModel: FavoriteListViewModelProtocol! { didSet { viewModel.delegate = self } }
    
    
    //MARK: Lifecycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupCollectionView()
        setupRefreshControl()
        showEmptyStateAnimationIfNeeded()
    }
}

//MARK: FavoriteListVC Lifecycle's

extension FavoriteListViewController {
    
    //MARK: -every page opening.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewDidLoad() //TODO: -
        setupRefreshControl()
        showEmptyStateAnimationIfNeeded()
    }
    
    //MARK: - when the screen is fully visible.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showEmptyStateAnimationIfNeeded()
        setupRefreshControl()
    }
    
    //MARK: - view while leaving the viewcontroller.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideEmptyStateAnimation()
    }
}

//MARK: Helper function.

extension FavoriteListViewController {
    
    private func setupCollectionView() {
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.register(FavoriteCollectionViewCell.self)
    }
    
    private func setupRefreshControl() {
        favoriteCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        favoriteCollectionView.reloadData()
    }
    
    @objc private func refreshData() {
        viewModel.viewDidLoad()
        favoriteCollectionView.reloadData()
        refreshControl.endRefreshing()
    }
}

extension FavoriteListViewController: FavoriteListViewModelDelegate {
    
    func handleViewModelOutput(_ output: FavoriteListViewModelOutput) {
        
        switch output {
        case .showFavoriteList(_):
            showEmptyStateAnimationIfNeeded()
            favoriteCollectionView.reloadData()
            
        case .setTitle(let title):
            self.navigationItem.title = title
        case .successRemoved(_):
            showEmptyStateAnimationIfNeeded()
            favoriteCollectionView.reloadData()
        }
    }
}

extension FavoriteListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfFavorites()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = Constants.System.CollectionViewCell.favoriteCollectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? FavoriteCollectionViewCell
        
        cell?.delegate = self
        
        if let favoriteData = viewModel.favoriteAt(index: indexPath.item) {
            
            print("şarkı idleri: ", favoriteData)
            
            cell?.id = Int(favoriteData.id)
            
            cell?.updateWith(favorites: favoriteData)
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectFavoriteAt(index: indexPath.item)
    }
}

extension FavoriteListViewController: UICollectionViewDelegate { }

extension FavoriteListViewController: FavoriteCollectionViewCellDelegate {
    
    func removeFromFavorite(id: Int) {
        viewModel.delegate?.handleViewModelOutput(.successRemoved(true))
        viewModel.removeFavoriteById(selectTrackId: id)
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
            hideEmptyStateAnimation() // Favori liste boş değilse animasyonu gizleyin
        }
    }
    
    private func hideEmptyStateAnimation() {
        animationView?.stop()
        animationView?.removeFromSuperview()
        animationView = nil
        favoriteCollectionView.isHidden = false
    }
}
