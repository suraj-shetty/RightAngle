//
//  LoginEnums.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 02/02/23.
//

import Foundation

enum OTPStatus {
    case unknown
    case duration(TimeInterval)
    case verified
}

enum InputStatus {
    case unverified
    case verifying
    case verified
    case notAvailable
}

enum OnboardField: Int, Hashable {
    case name, emailAddress, birthDate, phoneNumber, otp, userName, code
}
