//
//  String+Localization.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 06/02/23.
//

import Foundation

extension String {
    func countText(with count:UInt) -> String {
        let formatString = NSLocalizedString(self, comment: "")
        let result = String.localizedStringWithFormat(formatString, count)
        
        return result
    }
}
