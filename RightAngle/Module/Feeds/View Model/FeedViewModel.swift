//
//  FeedViewModel.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 08/03/23.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published var icon: String = ""
    @Published var title: String = ""
    @Published var authorName: String = ""
    @Published var viewCount: Int = 0
    
    init(icon: String, title:String, author: String, count: Int) {
        self.icon = icon
        self.title = title
        self.authorName = author
        self.viewCount = count
    }
}
