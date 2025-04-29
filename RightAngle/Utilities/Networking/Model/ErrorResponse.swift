//
//  ErrorResponse.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 01/04/23.
//

import Foundation

struct ErrorResponse: Codable {
    let error:ErrorDetail
}

struct ErrorDetail: Codable {
    let errors:[String]
    let info: [ErrorInfo]?
    let code: Int
    
    enum CodingKeys: String, CodingKey {
        case errors
        case info = "error_params"
        case code
    }
}

struct ErrorInfo: Codable {
    let msg: String
    
    enum CodingKeys: String, CodingKey {
        case msg
    }
}
