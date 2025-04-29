//
//  OTPRequest.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 05/04/23.
//

import Foundation

enum OTPRequestType: String, Encodable {
    case login = "login"
    case register = "register"
}

struct OTPRequest: Encodable {
    let input: String
    let countryCode: String?
    let type: OTPRequestType
    
    enum CodingKeys: String, CodingKey {
        case input = "mobileOrEmail"
        case countryCode
        case type
    }
}
