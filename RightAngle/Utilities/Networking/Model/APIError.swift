//
//  APIError.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 01/04/23.
//

import Foundation

enum APIError: Error, Hashable, Identifiable {
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        return lhs.description == rhs.description
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(description)
    }
    
    var id: Self { self }
    
    case invalidBody
    case invalidEndpoint
    case invalidURL
    case emptyData
    case invalidJSON
    case invalidResponse
    case statusCode(Int)
    case custom(String)
    case cancelled
    case noNetwork
    case unauthorized
    case unknown
    case error(Error)
}

extension APIError: CustomStringConvertible {
    var description: String {
        switch self {
        case .invalidBody:          return "Invalid bady sent for the request"
        case .invalidEndpoint:      return "Invalid API End-point used for the call"
        case .invalidURL:           return "Invalid API End-point used"
        case .emptyData:            return "Empty response data received"
        case .invalidJSON:          return "Invalid JSON data received"
        case .invalidResponse:      return "Invalid response received"
        case .statusCode(let code): return "Status \(code) received for the call"
        case .custom(let msg):      return msg
        case .cancelled:            return "Called Cancelled"
        case .noNetwork:            return "Internet not available"
        case .unauthorized:         return "Unauthorized"
        case .unknown:              return "Unknown error occured"
        case .error(let error):     return error.localizedDescription
        }
    }
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        return description
    }
}
