//
//  Constants.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 10.07.2023.
//


import Foundation
import UIKit

class Constant {
    
    static var screenWidth: CGFloat {
        get {
            if UIDevice.current.orientation.isLandscape {
                return max(UIScreen.main.bounds.size.height, UIScreen.main.bounds.size.width)
            } else {
                return min(UIScreen.main.bounds.size.height, UIScreen.main.bounds.size.width)
            }
        }
    }
    
}


