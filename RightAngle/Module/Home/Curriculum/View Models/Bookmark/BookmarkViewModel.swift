//
//  BookmarkViewModel.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 16/02/23.
//

import Foundation

class BookmarkViewModel: ObservableObject, Hashable, Identifiable {
    
    @Published var title: String = ""
    @Published var subTitle: String = ""
    @Published var author: String = ""
    @Published var progress: CGFloat = 0.67
    
    init(title: String, subTitle: String, author:String, progress:CGFloat) {
        self.title = title
        self.subTitle = subTitle
        self.author = author
        self.progress = progress
    }
    
    static func == (lhs: BookmarkViewModel, rhs: BookmarkViewModel) -> Bool {
        lhs.title == rhs.title &&
        lhs.subTitle == rhs.subTitle &&
        lhs.author == rhs.author &&
        lhs.progress == rhs.progress
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(subTitle)
        hasher.combine(author)
        hasher.combine(progress)
    }
}
