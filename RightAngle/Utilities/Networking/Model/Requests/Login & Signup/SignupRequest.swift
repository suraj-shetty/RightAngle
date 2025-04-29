//
//  SignupRequest.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 05/04/23.
//

import Foundation

struct SignupRequest: Encodable {
    let userName: String
    let name: String
    let email: String
    let referralCode: String?
    let mobileNumber: String
    let countryCode: String
    let dob: String
    
    enum CodingKeys: String, CodingKey {
        case userName = "username"
        case name
        case email
        case referralCode
        case mobileNumber
        case countryCode
        case dob
    }
}
