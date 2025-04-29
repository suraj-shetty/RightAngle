//
//  Encodable+Extensions.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 05/04/23.
//

import Foundation

extension Encodable{
    var dictionary : [String: Any]?{
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return nil }
        return json
    }
}
