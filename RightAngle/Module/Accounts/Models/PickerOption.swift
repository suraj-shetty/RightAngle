//
//  PickerOption.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 06/04/23.
//

import Foundation

struct PickerOption: Identifiable, Equatable {
    let id: Int
    let name: String
    
    static func == (lhs: PickerOption, rhs: PickerOption) -> Bool {
        return lhs.id == rhs.id
    }
}
