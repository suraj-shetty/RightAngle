//
//  SocialSignInRequest.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 05/04/23.
//

import Foundation

struct SocialSignInRequest: Codable {
    enum SocialSignType: String, Codable {
        case google = "google"
        case facebook = "fb"
        case apple = "apple"
    }
    
    let id: String
    let type: SocialSignType
    let name: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case id = "socialId"
        case type = "socialType"
        case name = "name"
        case email
    }
}
