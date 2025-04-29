//
//  ReelViewModel.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 09/03/23.
//

import Foundation

class ReelViewModel: ObservableObject {
    @Published var title: String = ""
    
    init(title: String) {
        self.title = title
    }
}
