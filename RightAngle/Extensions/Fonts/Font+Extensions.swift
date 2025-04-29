//
//  Font+Extensions.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 02/08/23.
//

import Foundation
import SwiftUI

public extension Font {
  init(uiFont: UIFont) {
    self = Font(uiFont as CTFont)
  }
}
