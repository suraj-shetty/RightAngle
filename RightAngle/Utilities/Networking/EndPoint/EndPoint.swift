//
//  EndPoint.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 01/04/23.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case connect = "CONNECT"
    case options = "OPTIONS"
    case trace = "TRACE"
    case patch = "PATCH"
}

protocol APIEndPoint {
    var url: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: Any]? { get }
    var body: [String: Any]? { get }
}
