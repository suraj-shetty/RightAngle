//
//  MessageResponse.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 17/04/23.
//

import Foundation

struct MessageResponse: Codable {
    let message: String
}

struct MessageResult: Codable {
    let result: MessageResponse
}
