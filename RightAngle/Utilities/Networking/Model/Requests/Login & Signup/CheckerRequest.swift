//
//  CheckerRequest.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 17/04/23.
//

import Foundation

struct CheckerRequest: Codable {
    enum CodingKeys: String, CodingKey {
        case userName = "username"
        case email = "email"
        case mobileNumber = "mobileNumber"
        case countryCode = "countryCode"
    }
    
    let userName: String?
    let email: String?
    let mobileNumber: String?
    let countryCode: String?
}
