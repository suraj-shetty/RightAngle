//
//  BoardPreferences.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 28/04/23.
//

import Foundation

struct BoardPreference: Decodable, Identifiable {
    let id: Int
    let name: String
    let status: PreferenceStatus
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
    }
}

struct BoardList: Decodable {
    let count: Int
    let rows: [BoardPreference]
}

struct BoardResult: Decodable {
    let result: [BoardPreference]
}
