//
//  SubjectViewModel.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 17/02/23.
//

import Foundation

class SubjectViewModel: ObservableObject, Hashable, Identifiable {
    @Published var title: String = ""
    @Published var count: Int = 0
    @Published var icon: String = ""
    
    init(title: String, count: Int, icon: String) {
        self.title = title
        self.count = count
        self.icon = icon
    }
    
    static func == (lhs: SubjectViewModel, rhs: SubjectViewModel) -> Bool {
        lhs.title == rhs.title &&
        lhs.count == rhs.count
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(count)
    }
}
