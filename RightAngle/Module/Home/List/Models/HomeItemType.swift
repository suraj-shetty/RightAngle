//
//  HomeItemType.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 06/02/23.
//

import Foundation
import SwiftUI

enum HomeRowType: Int {
    case curriculum = 0
    case supplementary
    case music
    case talks
}

extension HomeRowType {
    var title: String {
        switch self {
        case .curriculum:
            return "Curriculum Based"
        case .supplementary:
            return "Supplementary"
        case .music:
            return "Music & Entertainment"
        case .talks:
            return "Expert Talks"
        }
    }
    
    var icon: String {
        switch self {
        case .curriculum:
            return "curriculum"
        case .supplementary:
            return "supplementary"
        case .music:
            return "music"
        case .talks:
            return "talks"
        }
    }
    
    var color: Color {
        switch self {
        case .curriculum:
            return .paleGreen
        case .supplementary:
            return .paleYellow
        case .music:
            return .paleBlue
        case .talks:
            return .lavendar
        }
    }
}
