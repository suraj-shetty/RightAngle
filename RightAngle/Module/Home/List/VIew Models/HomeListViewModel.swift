//
//  HomeListViewModel.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 06/02/23.
//

import Foundation

class HomeListViewModel: ObservableObject {
    @Published var items = [HomeRowViewModel]()
    
    init() {
        self.items = [.init(type: .curriculum, count: 8),
                      .init(type: .supplementary, count: 56),
                      .init(type: .music, count: 130),
                      .init(type: .talks, count: 75)
        ]
    }
}
