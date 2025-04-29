//
//  ChapterViewModel.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 17/02/23.
//

import Foundation

class ChapterViewModel: ObservableObject, Hashable, Identifiable {
    let title: String
    let index: Int
    
    init(title: String, index:Int) {
        self.title = title
        self.index = index
    }
        
    static func == (lhs: ChapterViewModel, rhs: ChapterViewModel) -> Bool {
        lhs.title == rhs.title &&
        lhs.index == rhs.index
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(index)
    }
}
