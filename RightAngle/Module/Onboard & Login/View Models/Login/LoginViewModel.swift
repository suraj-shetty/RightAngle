//
//  LoginViewModel.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 01/02/23.
//

import Foundation
import UIKit
import CountryKit
import PhoneNumberKit
import SwiftEmailValidator
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import AuthenticationServices
import CryptoKit
import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
    private var verifiedPin: String = ""
    private var autoRefreshTimer: DispatchSourceTimer?
    fileprivate var currentNonce: String?
    
    private let apiService = OnboardService()
    
    private var appleLoginProxy: AppleLoginProxy? = nil
    
    @Published var isMobileNumber: Bool = false
    @Published var captureOTP: Bool = false
    @Published var canSubmit: Bool = false
    @Published var allowPinRequest: Bool = false
    @Published var loading: Bool = false
//    @Published var didLogin: Bool = false
    
    @Published var input: String = "" {
        didSet {
            if input != oldValue {
                checkInputType()
            }
        }
    }
    
    @Published var country: Country? = nil {
        didSet {
            if country?.phoneCode != oldValue?.phoneCode {
                checkInputType()
            }
        }
    }
    
    @Published var phoneNumber: String = ""{
        didSet {
            if phoneNumber != oldValue {
                phoneInputDidChange()
            }
        }
    }
    
    @Published var otp: String = "" {
        didSet {
            otpTextDidChange()
            updateInputState()
        }
    }
    
    @Published var otpStatus: OTPStatus = .unknown {
        didSet {
            updateInputState()
        }
    }
    
    
    init() {
        let countryKit = CountryKit()
        let currentCountry = countryKit.current ?? countryKit.searchByIsoCode("IN")
        
        if let country = currentCountry {
            self.country = country
        }
    }
    
    deinit {
        autoRefreshTimer?.cancel()
        autoRefreshTimer?.setEventHandler(handler: {})
    }
    
    //MARK: - Actions
    func switchCountry(with code: String) {
        let countryKit = CountryKit()
        self.country = countryKit.searchByIsoCode(code)
    }
    
    func login() async {
        var dialCode: String = ""
        if isMobileNumber {
            guard let code = country?.phoneCode
            else {
                AlertUtility.showErrorAlert(message: NSLocalizedString("profile.edit.error.number", comment: ""))
                return
            }
            
            let internationalNumber = "\(code)\(input)"
            let phoneKit = PhoneNumberKit()
            
            do {
                _ = try phoneKit.parse(internationalNumber) //Validating phone number
            }
            catch {
                AlertUtility.showErrorAlert(message: NSLocalizedString("profile.edit.error.number", comment: ""))
                return
            }
            dialCode = "\(code)"
        }
        
        self.loading = true
                
        let request = OTPRequest(input: input,
                                 countryCode: isMobileNumber
                                 ? "\(dialCode)"
                                 : nil,
                                 type: .login)
        
        let result = await apiService.requestOTP(with: request)
        switch result {
        case .success(let success):
            let response = success.result
            if response.isUserExist {
                withAnimation {
                    self.captureOTP = true
                }
                
                self.allowPinRequest = false
                self.otpStatus = .duration(2*60)
                self.runTimer()
            }
            else {
                DispatchQueue.main.async {
                    AlertUtility.showErrorAlert(message: "User doesn't exist for the provided email/phone number.")
                }
            }
            
            
        case .failure(let failure):
            DispatchQueue.main.async {
                AlertUtility.showErrorAlert(message: failure.localizedDescription)
            }
        }
        self.loading = false
    }
    
    func verify(with otp:String) {
    }
    
    func requestOTP() {
    }
    
    func verifyPin() async {
        var dialCode: String? = nil
        
        if isMobileNumber, let code = country?.phoneCode {
            dialCode = "\(code)"
        }
        
        self.loading = true
        
        let request = OTPVerifyRequest(input: input,
                                       countryCode: dialCode,
                                       otp: otp)
        let result = await apiService.verifyOTP(with: request)
        switch result {
        case .success(let success):
            let user = success.result
            self.saveDetail(user: user)
                        
        case .failure(let failure):
            DispatchQueue.main.async {
                AlertUtility.showErrorAlert(message: failure.localizedDescription)
            }
        }
        
        self.loading = false
        
    }
}

extension LoginViewModel {
    func googleLogin() {
        guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) ?? UIApplication.shared.windows.first,
                let topController = keyWindow.rootViewController
        else { return }
                
        GIDSignIn.sharedInstance.signIn(withPresenting: topController) {[weak self] result, error in
            if let error = error {
                AlertUtility.showErrorAlert(message: error.localizedDescription)
            }
            else if let user = result?.user,
                    let idToken = user.idToken?.tokenString,
                    let profile = user.profile {
                let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                               accessToken: user.accessToken.tokenString)
                self?.firebaseAuth(with: credential,
                                   name: profile.name,
                                   type: .google)
                GIDSignIn.sharedInstance.signOut()
            }
            else {
                AlertUtility.showErrorAlert(message: "User data is missing")
            }
        }
    }
    
    func appleLogin() {
        //        guard let vc = UIApplication.shared.keyWindow?.rootViewController
        //        else { return }
                
                let nonce = randomNonceString()
                currentNonce = nonce
                
                let provider = ASAuthorizationAppleIDProvider()
                let request = provider.createRequest()
                request.requestedScopes = [.email, .fullName]
                request.nonce = sha256(nonce)
                
                let loginProxy = AppleLoginProxy()
                loginProxy.callback = {[weak self] credential in
                    
                    guard let nonce = self?.currentNonce else {
                        return
                        //                    fatalError("Invalid state: A login callback was received, but no login request was sent.")
                    }
                    guard let appleIDToken = credential.identityToken else {
                        print("Unable to fetch identity token")
                        return
                    }
                    guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                        print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                        return
                    }
                    
                    let authCredential = OAuthProvider.credential(withProviderID: "apple.com",
                                                                  idToken: idTokenString,
                                                                  rawNonce: nonce)
                    
                    var name = credential.fullName?.formatted() ?? ""
                    var email = credential.email ?? ""
                    let keychain = KeyChainService()
                    
                    if !name.isEmpty, !email.isEmpty {
                        keychain.saveAppleUserName(name: name)
                        keychain.saveAppleEmail(email: email)
                        keychain.saveAppleUserID(userID: credential.user)
                    }
                    else {
                        name = keychain.appleUserName ?? ""
                        email = keychain.appleUserEmail ?? ""
                    }
                    
                    self?.firebaseAuth(with: authCredential,
                                       name: name,
                                       type: .apple)
                    
        //            let request = SocialSignInRequest(id: credential.user,
        //                                              type: .apple,
        //                                              name: name,
        //                                              email: email)
        //            self?.socialLogin(with: request)
                    self?.appleLoginProxy = nil
                }
                
                self.appleLoginProxy = loginProxy
                
                let authController = ASAuthorizationController(authorizationRequests: [request])
                authController.delegate = loginProxy
                authController.performRequests()
        //        authController.presentationContextProvider  =
            }
    
    
    private func firebaseAuth(with credential: AuthCredential,
                              name: String,
                              type: SocialSignInRequest.SocialSignType
    ) {
        loading = true
        
        Auth.auth().signIn(with: credential) {[weak self] result, error in
            self?.loading = false
            if let error = error {
                AlertUtility.showErrorAlert(message: error.localizedDescription)
            }
            else if let result = result {
                let user = result.user
                let email = user.email
                let uid = user.uid
                
                let request = SocialSignInRequest(id: uid,
                                                  type: type,
                                                  name: name,
                                                  email: email ?? "")
                self?.socialLogin(with: request)
                GIDSignIn.sharedInstance.signOut()
                
                do {
                    try Auth.auth().signOut()
                }
                catch {
                    
                }
                
            }
        }
    }
        
    private func socialLogin(with request: SocialSignInRequest) {
        if request.name.isEmpty || request.email.isEmpty {
            AlertUtility.showErrorAlert(message: "Unable to login since name/email address is empty.")
            return
        }
        
        loading = true
        
        Task {
            let result = await apiService.socialLogin(with: request)
            self.loading = false
            
            switch result {
            case .success(let success):
                let user = success.result
                //
                //                    let mobileNumber = user.mobileNumber
                //                    let dialCode = user.dialCode ?? "0"
                //
                //                    if mobileNumber == "0" || dialCode == "0" {
                //                        self.socialLoginRequest = request
                //                        self.capturePhoneNumber = true
                //                    }
                //                    else {
                self.saveDetail(user: user)
//                self.didLogin = true
                //                    }
                
            case .failure(let failure):
                DispatchQueue.main.async {
                    AlertUtility.showErrorAlert(message: failure.localizedDescription)
                }
            }
        }
    }
}
    
    private extension LoginViewModel {
        func saveDetail(user: UserResponse) {
            
            AppSession.shared.userSubject.send(user)
        
            self.loading = true
            DispatchQueue.main.asyncAfter(deadline: .now()) {[weak self] in
                self?.loading = false
                
                NotificationCenter.default
                    .post(name: .loggedIn,
                          object: nil)
                
//                self?.didLogin = true
            }
        }
    }
    
private extension LoginViewModel {
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError(
              "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }
}


private extension LoginViewModel {
    func checkInputType() { //Checking whether input is either email address or mobile number
        
        let inputText = input.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !inputText.isEmpty
        else { //If empty string, hide country code region
            isMobileNumber = false
            return
        }
        
        let nonDigitString = inputText
            .components(separatedBy: .decimalDigits)
            .joined()
        
        isMobileNumber = nonDigitString.isEmpty
        
        //If 10 digits are entered and is a phone number
        if nonDigitString.isEmpty, inputText.count == 10 {
//            self.inputFocussed = false
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            self.canSubmit = true
        }
        else if !inputText.isEmpty, EmailSyntaxValidator.correctlyFormatted(inputText) {
            self.canSubmit = true
        }
        else {
            self.canSubmit = false
        }
    }
    
    func updateInputState() {
//        let hasPhoneNumber = (country != nil) && !phoneNumber.isEmpty
//
//        var didVerify: Bool = false
//        switch otpStatus {
//        case .verified:
//            didVerify = true
//
//        default:
//            didVerify = false
//        }
//
//        let canSubmit = hasPhoneNumber && didVerify
//        self.canSubmit = canSubmit
    }
    
    func phoneInputDidChange() {
        otpStatus = .unknown
        stopTimer()
        updateInputState()
    }
    
    func otpTextDidChange() {
        if !verifiedPin.isEmpty {
            if verifiedPin == otp {
                otpStatus = .verified
            }
            else {
                otpStatus = .duration(0)
                allowPinRequest = true
            }
            updateInputState()
        }
        else {
            
        }
    }
    
    //MARK: - Timer
    func runTimer() {
        if autoRefreshTimer?.isCancelled == false {
            stopTimer()
        }
        
        let queue = DispatchQueue.main
        autoRefreshTimer = DispatchSource.makeTimerSource(queue: queue)
        autoRefreshTimer?.schedule(deadline: .now(),
                                   repeating: .seconds(1))
        autoRefreshTimer?.setEventHandler(handler: {[weak self] in
            guard let ref = self
            else { return }
            
            switch ref.otpStatus {
            case .duration(let interval):
                let updatedInterval = interval - 1
                ref.otpStatus = .duration(updatedInterval)
                
                if updatedInterval <= 0 {
                    ref.allowPinRequest = true
                    ref.stopTimer()
                }
                break
                
            default: break
            }
        })
        
        autoRefreshTimer?.resume()
    }
    
    func stopTimer() {
        autoRefreshTimer?.cancel()
        autoRefreshTimer = nil
    }
}


class AppleLoginProxy: NSObject, ASAuthorizationControllerDelegate {
    var callback: ((ASAuthorizationAppleIDCredential) ->())? = nil
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            self.callback?(appleIDCredential)
                        
        default: break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        var message = ""
        
        if let authError = error as? ASAuthorizationError {
            switch authError.code {
            case .canceled: message = "The user canceled the the sign-in flow."
            case .failed: message = "Failed to authorise the login."
            default: message = authError.localizedDescription
            }
        }
        else {
            message = error.localizedDescription
        }
        
        AlertUtility.showErrorAlert(message: message)
    }
}
