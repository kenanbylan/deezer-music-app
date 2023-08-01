//
//  MusicListViewController.swift
//  deezer-music-app
//

import UIKit

final class GenreListViewController: UIViewController {
    @IBOutlet private weak var genreCollectionView: UICollectionView! {
        didSet {
            genreCollectionView.delegate = self
            genreCollectionView.dataSource = self
        }
    }
    var viewModel: GenreListViewModelProtocol! { didSet { viewModel.delegate = self } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !NetworkHelper.isConnectedToNetwork() {
            showNoInternetAlert()
            
            return
        }
        viewModel?.viewDidLoad()
        genreCollectionView.register(CategoryCollectionViewCell.self)
        setupUI()
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
        
        guard let genre = viewModel.genreAt(indexPath.item) else { return UICollectionViewCell() }
        cell.updateUIWith(genre: genre)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectGenreAt(indexPath.item)
    }
}

extension GenreListViewController: UICollectionViewDelegateFlowLayout { }

extension GenreListViewController {
    private func showNoInternetAlert() {
        DeezerAlert.shared.showAlert(title: "No internet connection" , message: "Controll_alert_msg".localizable) {
            self.viewModel.coordinator?.start()
        }
    }
    func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }
}
