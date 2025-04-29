//
//  ReelsListViewModel.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 09/03/23.
//

import Foundation

class ReelsListViewModel: ObservableObject {
    @Published var reels = [ReelViewModel]()
    @Published var index: Int = 0
    
    init() {
        let reels = [
            ReelViewModel(title: "It is a long established fact that a reader will be distracted by the readable"),
            ReelViewModel(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
            ReelViewModel(title: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
            ReelViewModel(title: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."),
            ReelViewModel(title: "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
            ReelViewModel(title: "Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt, explicabo."),
            ReelViewModel(title: "Nemo enim ipsam voluptatem, quia voluptas sit, aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos.")
        ]
        
        self.reels = reels
    }
}
