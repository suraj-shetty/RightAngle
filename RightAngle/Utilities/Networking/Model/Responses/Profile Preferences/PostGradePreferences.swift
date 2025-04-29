//
//  PostGradePreferences.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 28/04/23.
//

import Foundation

struct PostGradePreference: Decodable, Identifiable {
    let id: Int
    let name: String
    let status: PreferenceStatus
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
    }
}

struct PostGradeList: Decodable {
    let count: Int
    let rows: [PostGradePreference]
}

struct PostGradeResult: Decodable {
    let result: PostGradeList
}
