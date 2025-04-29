//
//  OTPVerifyRequest.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 05/04/23.
//

import Foundation

struct OTPVerifyRequest: Encodable {
    let input: String
    let countryCode: String?
    let otp: String
    
    enum CodingKeys: String, CodingKey {
        case input = "mobileOrEmail"
        case countryCode
        case otp
    }
}
