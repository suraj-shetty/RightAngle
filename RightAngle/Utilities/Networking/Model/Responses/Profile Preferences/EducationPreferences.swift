//
//  EducationPreferences.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 28/04/23.
//

import Foundation

struct EducationPreference: Decodable, Identifiable, Equatable {
    let id: Int
    let name: String
    let status: PreferenceStatus
    let underGrades: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case underGrades = "isUnderGrades"
    }
    
    static func == (lhs: EducationPreference, rhs: EducationPreference) -> Bool {
        return lhs.id == rhs.id
    }
}

struct EducationList: Decodable {
    let count: Int
    let rows: [EducationPreference]
}

struct EducationResult: Decodable {
    let result: EducationList
}
