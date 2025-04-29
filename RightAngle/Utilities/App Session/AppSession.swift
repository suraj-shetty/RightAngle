//
//  AppSession.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 07/04/23.
//

import Foundation
import Combine

class AppSession: NSObject {
    let userSubject = CurrentValueSubject<UserResponse?, Never>(nil)
    
    private var cancellables = Set<AnyCancellable>()
    
    static var shared: AppSession = {
        return AppSession()
    }()
    
    override init() {
        super.init()
        
        userSubject.sink {[weak self] response in
            if let response = response {
                self?.saveDetail(user: response)
            }
            else {
                self?.clear()
            }
        }
        .store(in: &cancellables)
    }
    
    private func saveDetail(user: UserResponse) {
        SGUserDefaultStorage.saveUserData(user: user)
        SGUserDefaultStorage.saveToken(token: user.token)
    }
    
    private func clear() {
        SGUserDefaultStorage.clearData()
    }
}
