//
//  GradePreferences.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 28/04/23.
//

import Foundation

struct UnderGradePreference: Decodable, Identifiable {
    let id: Int
    let name: String
    let status: PreferenceStatus
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
    }
}

struct UnderGradeList: Decodable {
    let count: Int
    let rows: [UnderGradePreference]
}

struct UnderGradeResult: Decodable {
    let result: UnderGradeList
}
