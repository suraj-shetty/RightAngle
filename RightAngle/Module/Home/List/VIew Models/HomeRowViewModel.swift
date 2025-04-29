//
//  HomeRowViewModel.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 06/02/23.
//

import Foundation

class HomeRowViewModel: ObservableObject {
    var type: HomeRowType
    var subTitle: String
    
    init(type: HomeRowType, count: UInt) {
        self.type = type
        
        switch type {
        case .curriculum:
            self.subTitle = "home.item.curriculum".countText(with: count)
        case .supplementary:
            self.subTitle = "home.item.supplementary".countText(with: count)
        case .music:
            self.subTitle = "home.item.music".countText(with: count)
        case .talks:
            self.subTitle = "home.item.talks".countText(with: count)
        }
    }
}
