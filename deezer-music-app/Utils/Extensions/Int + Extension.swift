//
//  Int + Extension.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 20.07.2023.
//

import Foundation

extension Int {
    func formatDuration() -> String {
        let minutes = self / 60
        let seconds = self % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
