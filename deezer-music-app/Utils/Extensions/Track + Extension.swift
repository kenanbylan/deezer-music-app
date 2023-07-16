//
//  Track + Extension.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 16.07.2023.
//

import Foundation

extension Track {
    var formattedDuration: String {
        let minutes = duration! / 60
        let seconds = duration! % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
