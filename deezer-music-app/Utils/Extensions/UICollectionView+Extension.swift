//
//  UICollectionView+Extension.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 10.07.2023.
//

import Foundation
import UIKit


extension UICollectionViewCell {

    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    public func register(_ cellClass: UICollectionViewCell.Type) {
        register(UINib(nibName: cellClass.identifier, bundle: nil), forCellWithReuseIdentifier: cellClass.identifier)
    }
}
