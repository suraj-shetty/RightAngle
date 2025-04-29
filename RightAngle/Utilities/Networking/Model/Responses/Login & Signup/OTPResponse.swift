//
//  OTPResponse.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 05/04/23.
//

import Foundation


struct OTPResponse: Codable {
    let isUserExist: Bool
}

struct OTPResult: Codable {
    let result: OTPResponse
}
