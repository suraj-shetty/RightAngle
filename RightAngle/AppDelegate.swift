//
//  AppDelegate.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 08/03/23.
//

import Foundation
import UIKit
import FirebaseCore
import AuthenticationServices
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
    static var orientationLock = UIInterfaceOrientationMask.portrait

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        if let clientID = FirebaseApp.app()?.options.clientID {
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config
        }
                        
        let keychain = KeyChainService()
        
        if let userID = keychain.appleUserID, !userID.isEmpty {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: userID) { (credentialState, error) in
                switch credentialState {
                case .authorized:
                    break // The Apple ID credential is valid.
                case .revoked:
                    // The Apple ID credential is either revoked or was not found
                    keychain.deleteSavedAppleUserInfo()
                default:
                    break
                }
            }
        }
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
    
    static func updateOrientationLock(to lock: UIInterfaceOrientationMask) {
        AppDelegate.orientationLock = lock
//        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
//        UINavigationController.setNeedsUpdateOfSupportedInterfaceOrientations(<#T##self: UIViewController##UIViewController#>)
    }
}
