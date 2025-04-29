//
//  AvatarPickerViewModel.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 07/04/23.
//

import Foundation

class AvatarPickerViewModel: ObservableObject {
    let title: String
    let options: [String]
    
    @Published var picked: String? = nil
    
    init(title: String, options:[String], picked: String?) {
        self.title = title
        self.options = options
        self.picked = picked
    }
}
