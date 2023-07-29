//
//  UIColor + Extension.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 28.07.2023.
//

import UIKit


extension UIColor {
    var isLightColor: Bool {
        guard let components = cgColor.components, components.count >= 3 else {
            return false
        }
        let brightness = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000
        return brightness > 0.5
    }
}
