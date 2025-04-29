//
//  Bundle+Extensions.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 10/04/23.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    var releaseVersionNumberPretty: String {
        return "Version \(releaseVersionNumber ?? "1.0.0")"
    }
}
