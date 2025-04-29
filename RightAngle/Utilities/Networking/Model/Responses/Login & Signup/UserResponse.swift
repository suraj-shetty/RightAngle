//
//  UserResponse.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 05/04/23.
//

import Foundation

struct UserResponse: Codable {
    let name: String
    let id: Int
    let role: String
    let mobileNumber: String?
    let countryCode: String?
    let bio: String?
    let dob: String?
    let picture:String?
    let email: String?
    let socialType: String?
    let token: String
}

struct UserResult: Codable {
    let result: UserResponse
}
