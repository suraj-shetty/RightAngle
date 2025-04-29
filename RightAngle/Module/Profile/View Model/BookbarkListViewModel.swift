//
//  BookbarkListViewModel.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 12/04/23.
//

import Foundation

class BookmarkListViewModel: ObservableObject {
    @Published var lessons: [BookmarkViewModel] = [
        .init(title: "Measurement, data and geometry 1",
              subTitle: "Math, Chapter 5",
              author: "Manish Malhotra",
              progress: 0.67),
        .init(title: "Measurement, data and geometry 2",
              subTitle: "Math, Chapter 6",
              author: "Manish Malhotra",
              progress: 0.57)
    ]
    
    @Published var type: BookmarkListType = .lessons
}
