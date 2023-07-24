//
//  MiniPlayerViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 21.07.2023.
//

import UIKit

protocol MiniPlayerDelegate {
    func presentPlayerView()
}

class MiniPlayerViewController: UIViewController {

    var delegate: MiniPlayerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBrown
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
    }
    
    @objc func tapDetected() {
        guard let delegate = delegate else { return }
        delegate.presentPlayerView()
    }
}
