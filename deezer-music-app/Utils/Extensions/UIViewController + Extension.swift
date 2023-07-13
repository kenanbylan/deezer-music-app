//
//  UIViewController + Extension.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 13.07.2023.
//

import UIKit.UIViewController

extension UIViewController {
    var className: String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
}
