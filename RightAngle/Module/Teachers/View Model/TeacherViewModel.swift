//
//  TeacherViewModel.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 10/03/23.
//

import Foundation

class TeacherViewModel: ObservableObject {
    @Published var name: String = ""
    
    init(name: String) {
        self.name = name
    }
}
