//
//  MiniBar.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 21.07.2023.
//

import UIKit


protocol MiniBarPlayerDelegate: AnyObject {
    func trackPauseTap()
}


class MiniBarPlayer: UIView {
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var trackPauseButton: UIButton!
    
    var delegate: MiniBarPlayerDelegate?
    
    
    override func awakeFromNib() { // Değiştirildi
        super.awakeFromNib()
        
        guard let view = Bundle.main.loadNibNamed("MiniBarPlayer", owner: self, options: nil)?.first as? UIView else {
            fatalError("Could not load MiniBarPlayer Nib")
        }
        
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    
    func updateWith(trackImage: UIImage, trackTitle:String) {
        self.trackImageView.image = trackImage //TODO will be changes.
        self.trackTitle.text = trackTitle
    }
    
    @IBAction func trackPauseButtonTapped(_ sender: Any) {
        delegate?.trackPauseTap()
    }
}
