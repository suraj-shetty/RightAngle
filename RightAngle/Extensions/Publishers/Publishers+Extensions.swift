//
//  Publishers+Extensions.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 02/02/23.
//

import Foundation
import Combine
import UIKit

extension Publishers {
    static var keyboardPublisher: AnyPublisher<Bool, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { _ in true }
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in false }
        
        return Publishers.Merge(willShow, willHide)
            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    static var loggedInOutPublisher: AnyPublisher<Bool, Never> {
        let didLogIn = NotificationCenter.default.publisher(for: .loggedIn)
            .map { _ in true }
        
        let didLogOut = NotificationCenter.default.publisher(for: .loggedOut)
            .map { _ in false }
        
        return Publishers.Merge(didLogIn, didLogOut)
            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    static var menuShowHidePublisher: AnyPublisher<Bool, Never> {
        let menuShow = NotificationCenter.default.publisher(for: .menuShow)
            .map { _ in true }
        
        let menuHide = NotificationCenter.default.publisher(for: .menuHide)
            .map { _ in false }
        
        return Publishers.Merge(menuShow, menuHide)
            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

extension Notification.Name {
    static let loggedIn   = Notification.Name("LoggedIn")
    static let loggedOut  = Notification.Name("LoggedOut")
    static let menuShow   = Notification.Name("Menu Show")
    static let menuHide   = Notification.Name("Menu Hide")
}
