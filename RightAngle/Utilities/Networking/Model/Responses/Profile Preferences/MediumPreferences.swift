//
//  MediumPreferences.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 28/04/23.
//

import Foundation

struct MediumPreference: Decodable, Identifiable {
    let id: Int
    let name: String
    let status: PreferenceStatus
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
    }
}

struct MediumList: Decodable {
    let count: Int
    let rows: [MediumPreference]
}

struct MediumResult: Decodable {
    let result: [MediumPreference]
}
