//
//  SideMenuViewModel.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 10/04/23.
//

import Foundation

class SideMenuViewModel: ObservableObject {
    let options:[SideMenuOption] = [.home, .profile, .notifications, .bookmarks, .purchases]//, .wallets]
    @Published var current: SideMenuOption = .home
    @Published var referFriends: Bool = false
    @Published var version: String = ""
    @Published var showMenu: Bool = false
    init() {
        self.version = Bundle.main.releaseVersionNumberPretty
    }
}
