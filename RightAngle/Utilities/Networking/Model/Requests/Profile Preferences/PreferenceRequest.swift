//
//  EducationPreferenceRequest.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 28/04/23.
//

import Foundation

struct LocationPreferenceRequest: Encodable {
    let start: Int
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case start = "offset"
        case count = "limit"
    }
}

struct EducationPreferenceRequest: Encodable {
    let locationID: Int
    let start: Int
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case locationID = "locationId"
        case start = "offset"
        case count = "limit"
    }
}

struct UnderGradesPreferenceRequest: Encodable {
    let educationID: Int
    let start: Int
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case educationID = "educationId"
        case start = "offset"
        case count = "limit"
    }
}

struct PostGradesPreferenceRequest: Encodable {
    let start: Int
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case start = "offset"
        case count = "limit"
    }
}

struct MediumPreferenceRequest: Encodable {
    let start: Int
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case start = "offset"
        case count = "limit"
    }
}

struct BoardPreferenceRequest: Encodable {
    let start: Int
    let count: Int
    
    enum CodingKeys: String, CodingKey {        
        case start = "offset"
        case count = "limit"
    }
}
