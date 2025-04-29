//
//  NotificationViewModel.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 11/04/23.
//

import Foundation

class NotificationViewModel: ObservableObject {
    let notification: NotificationInfo
    
    init(with notification: NotificationInfo) {
        self.notification = notification
    }
}
