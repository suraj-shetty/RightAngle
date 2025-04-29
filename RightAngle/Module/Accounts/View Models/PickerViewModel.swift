//
//  PickerViewModel.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 06/04/23.
//

import Foundation

class PickerViewModel: ObservableObject {
    let title: String
    let options: [PickerOption]
    
    @Published var picked: PickerOption? = nil
    
    init(title: String, options:[PickerOption], picked: PickerOption?) {
        self.title = title
        self.options = options
        self.picked = picked
    }
}
