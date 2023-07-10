//
//  ArtistListViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 11.07.2023.
//

import UIKit

class ArtistListViewController: UIViewController {

    @IBOutlet weak var artistListCollectionView: UICollectionView!
    
    let viewModel = ArtistListViewModel()

    var artistId: Int
    
    init(artistId: Int) {
         self.artistId = artistId
         super.init(nibName: nil, bundle: nil)
     }
     
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCollectionView()
    }
    
    private func registerCollectionView() {
        artistListCollectionView.register(CategoryCollectionViewCell.self)
    }


}



extension ArtistListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
        
        let reuseIdentifier = CategoryCollectionViewCell.identifier
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCollectionViewCell.self) , for: indexPath) as! CategoryCollectionViewCell
        
        
        cell.categoryTitle.text
        = "dendemee"
        
        return cell
    }
    
    
    
}
