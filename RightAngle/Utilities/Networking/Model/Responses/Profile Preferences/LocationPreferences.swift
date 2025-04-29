//
//  LocationPreferences.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 28/04/23.
//

import Foundation

struct LocationPreference: Decodable, Identifiable {
    let id: Int
    let name: String
    let status: PreferenceStatus
}

struct LocationList: Decodable {
    let count: Int
    let rows: [LocationPreference]
}

struct LocationResult: Decodable {
    let result: [LocationPreference]
}
