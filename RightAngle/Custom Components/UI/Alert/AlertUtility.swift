//
//  AlertUtility.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 16/02/23.
//

import Foundation
import UIKit
import SwiftMessages
import IHProgressHUD

class AlertUtility {
    class func showErrorAlert(_ title:String? = nil, message:String?) {
        let iconStyle = IconStyle.default
        let image = iconStyle.image(theme: Theme.error)
        
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureDropShadow()
        view.configureContent(title: title,
                              body: message,
                              iconImage: image,
                              iconText: nil,
                              buttonImage: nil,
                              buttonTitle: nil,
                              buttonTapHandler: nil)
        view.button?.isHidden = true
        
        var config = SwiftMessages.defaultConfig
        config.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        SwiftMessages.show(config: config, view: view)
    }
}

extension AlertUtility {
    class func configureHUD() {
        IHProgressHUD.set(defaultStyle: .dark)
        IHProgressHUD.set(defaultMaskType: .clear)
        IHProgressHUD.set(foregroundColor: .textBlack)
    }
    
    class func showHUD() {
        IHProgressHUD.show()
    }
    
    class func hidHUD() {
        IHProgressHUD.dismiss()
    }
}
