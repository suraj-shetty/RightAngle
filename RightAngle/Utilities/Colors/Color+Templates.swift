//
//  Color+Templates.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 27/01/23.
//

import Foundation
import SwiftUI

extension Color {
    static var baseGrey: Color {
        return .raisinBlack
    }
    
    static var base: Color {
        return .white
    }
    
    static var background: Color {
        return .white
    }
    
    static var textWhite: Color {
        return .white
    }
    
    static var textBlack: Color {
        return .raisinBlack
    }
    
    static var textPlaceholder: Color {
        return .raisinBlack
            .opacity(0.54)
    }
    
    static var navText: Color {
        return .raisinBlack
    }
    
    static var infoText: Color {
        return .hexColor(hex: 0x717171)
    }
    
    static var infoHighlight: Color {
        return .raisinBlack
    }
    
    static var strokeBorder: Color {
        return .hexColor(hex: 0xD9D9D9)
    }
    
    static var submit: Color {
        return .raisinBlack
    }
    
    static var seperator: Color {
        return .hexColor(hex: 0xD5D5D5)
    }
    
    static var curriculumHeader: Color {
        return .paleGrey
    }
    
    static var curriculumTitle: Color {
        return grey1
    }
    
    static var chapterListTitle: Color {
        return paleGrey3
    }
    
    static var chapterSeparator: Color {
        return paleGrey
    }
    
    static var teacherSectionSeparator: Color {
        return paleGrey
    }
    
    static var trendingTitle: Color {
        return grey1
    }
    
    static var pinBackground: Color {
        return paleGrey
    }
    
    static var optionEmpty: Color {
        return paleGrey4
    }
    
    static var avatarOverlay: Color {
        return .davyGrey
    }
    
    static var accountCardBg: Color {
        return .ghostWhite
    }
    
    static var accountCardBorder: Color {
        return .ghostWhite
            .opacity(0.02)
    }
    
    static var referButtonBg: Color {
        return .teaGreen
    }
    
    static var profileSeparator: Color {
        return .brightGray
    }
    
    static var notificationBadge: Color {
        return .tartOrange
    }
    
    static var tabNormal: Color {
        return .black.opacity(0.6)
    }
    
    static var tabHighlight: Color {
        return .black
    }
    
    static var profileBorder: [Color] {
        return [
            .teaGreen,
            .pastelYellow
        ]
    }
    
    static var profileTagText: Color {
        return .spanishGray
    }
    
    static var profileTagBackground: Color {
        return .brightGray2
    }
}

extension Color {
    static var paleGreen: Color {
        return .hexColor(hex: 0xC9FDC7)
    }
    
    static var paleYellow: Color {
        return .hexColor(hex: 0xFBF398)
    }
    
    static var paleBlue: Color {
        return .hexColor(hex: 0xD2F3FC)
    }
    
    static var lavendar: Color {
        return .hexColor(hex: 0xDDDFFE)
    }
    
    static var paleGrey: Color {
        return .hexColor(hex: 0xF3F5F7)
    }
    
    static var paleGrey2: Color {
        return .hexColor(hex: 0xE1E1E1)
    }
    
    static var paleGrey3: Color {
        return .hexColor(hex: 0xABABAB)
    }
    
    static var paleGrey4: Color {
        return .hexColor(hex: 0xEEEEEE)
    }
    
    static var grey1: Color {
        return .hexColor(hex: 0x929292)
    }
    
    static var brightGray: Color {
        return .hexColor(hex: 0xECECEC)
    }
    
    static var white2: Color {
        return .hexColor(hex: 0xFFF8F6)
    }
    
    static var davyGrey: Color {
        return .hexColor(hex: 0x525252)
    }
    
    static var ghostWhite: Color {
        return .hexColor(hex: 0xFBF8F6)
    }
    
    static var raisinBlack: Color {
        return .hexColor(hex: 0x212121)
    }
    
    static var teaGreen: Color {
        return .hexColor(hex: 0xC9FDC7)
    }
    
    static var tartOrange: Color {
        return .hexColor(hex: 0xF34848)
    }
    
    static var pastelYellow: Color {
        return .hexColor(hex: 0xFBF398)
    }
    
    static var chineseSilver: Color {
        return .hexColor(hex: 0xC9C9C9)
    }
        
    static var spanishGray: Color {
        return .hexColor(hex: 0x979797)
    }
    
    static var brightGray2: Color {
        return .hexColor(hex: 0xEDEDED)
    }
}

extension UIColor {
    @nonobjc class var textBlack: UIColor {
        return UIColor(rgb: 0x212121)
    }
}
