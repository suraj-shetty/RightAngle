//
//  AccountInfoViewModel.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 08/04/23.
//

import Foundation

class AccountInfoViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var subTitle: String = ""
    @Published var avatar: String = ""
    
    private let info: AccountInfo
    
    init(info: AccountInfo) {
        self.info = info
        self.title = info.name
        self.subTitle = [info.grade, info.board].joined(separator: ", ")
        self.avatar = info.avatar
    }
}
