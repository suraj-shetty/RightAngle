//
//  String+Extensions.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 08/03/23.
//

import Foundation
import SwiftUI
import KMBFormatter

extension String {
    var localizedKey:LocalizedStringKey {
        return LocalizedStringKey(self)
    }
    
    func countString(value:Int) -> String {
        let formattedValue = KMBFormatter.shared.string(fromNumber: Int64(value))
        
        let formatText = NSLocalizedString(self, comment: "")
        let text = String.localizedStringWithFormat(formatText, formattedValue, value)
        return text
    }
}

