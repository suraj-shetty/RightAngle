//
//  AccountListViewModel.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 08/04/23.
//

import Foundation

class AccountListViewModel: ObservableObject {
    @Published var list = [AccountInfo]()
}
