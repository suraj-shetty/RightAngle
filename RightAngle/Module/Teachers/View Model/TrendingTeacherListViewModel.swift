//
//  TrendingTeacherListViewModel.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 10/03/23.
//

import Foundation

class TrendingTeacherListViewModel: ObservableObject {
    @Published var teachers = [TeacherViewModel]()
    
    init() {
        self.teachers = [
            TeacherViewModel(name: "Bessie Cooper"),
            TeacherViewModel(name: "Brooklyn Simmons"),
            TeacherViewModel(name: "Dianne R Garret"),
            TeacherViewModel(name: "Cody Fisher"),
            TeacherViewModel(name: "Cameron Williamson"),
        ]
    }
}
