//
//  SideMenuOption.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 10/04/23.
//

import Foundation

enum SideMenuOption: String, Hashable, Identifiable {
    case home = "Home"
    case profile = "Profile"
    case notifications = "Notifications"
    case bookmarks = "Bookmarks"
    case purchases = "Purchases"
    case wallets = "Wallets"
    
    var id: Self { self }
}
