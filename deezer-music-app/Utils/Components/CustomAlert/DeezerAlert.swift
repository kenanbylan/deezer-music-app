//
//  DeezerAlert.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 27.07.2023.
//

import UIKit

enum AlertType {
    case success
    case failure
}


class DeezerAlert: UIView {
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertTitle: UILabel!
    @IBOutlet weak var alertDescriptionLabel: UILabel!
    @IBOutlet weak var alertCancelButtonTapped: UIButton!
    
    static let shared = DeezerAlert()
    
    override private init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("DeezerAlert", owner: self, options: nil)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var cancelAction: (() -> Void)?
    
    func showAlert(title: String, message: String, onCancelTapped: (() -> Void)?) {
        self.alertTitle.text = title
        self.alertDescriptionLabel.text = message
        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        keyWindow?.addSubview(parentView)
        
        parentView.alpha = 0.0
        parentView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        cancelAction = onCancelTapped
        
        UIView.animate(withDuration: 0.3) {
            self.parentView.alpha = 1.0
            self.parentView.transform = CGAffineTransform.identity
        }
    }
    
    @IBAction func alertCancelButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.parentView.alpha = 0.0
            self.parentView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { _ in
            self.parentView.removeFromSuperview()
            self.cancelAction?()
        }
    }
}

//MARK: - SetupUI

extension DeezerAlert {
    
    func setupUI() {
        alertView.backgroundColor = .lightGray
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        alertView.layer.cornerRadius = 10
    }
}
