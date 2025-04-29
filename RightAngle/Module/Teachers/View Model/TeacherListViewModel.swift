//
//  TeacherListViewModel.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 10/03/23.
//

import Foundation

class TeacherListViewModel: ObservableObject {
    @Published var teachers = [TeacherViewModel]()
    
    init() {
        self.teachers = [
            TeacherViewModel(name: "Bessie Cooper"),
            TeacherViewModel(name: "Cameron Williamson"),
            TeacherViewModel(name: "Floyd Miles"),
            TeacherViewModel(name: "Brooklyn Simmons"),
            TeacherViewModel(name: "Dianne R Garret"),
            TeacherViewModel(name: "Cody Fisher")            
        ]
    }
}
