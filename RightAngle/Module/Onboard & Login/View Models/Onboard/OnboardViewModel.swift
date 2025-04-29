//
//  OnboardViewModel.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 16/02/23.
//

import Foundation

import Foundation
import PhoneNumberKit
import CountryKit
import SwiftEmailValidator

@MainActor
class OnboardViewModel: ObservableObject {
    @Published var name: String = "" {
        didSet {
            if name != oldValue {
                updateInputState()
            }
        }
    }
    
    @Published var username: String = ""
    
    @Published var email: String = "" {
        didSet {
            if email != oldValue {
                updateInputState()
            }
        }
    }
    
    @Published var birthDate: Date? = nil
    @Published var country: Country? = nil {
        didSet {
            if country?.phoneCode != oldValue?.phoneCode {
                phoneInputDidChange()
            }
        }
    }
    
    @Published var referralCode:String = ""
    
    @Published var phoneNumber: String = "" {
        didSet {
            if phoneNumber != oldValue {
                phoneInputDidChange()
            }
        }
    }
    @Published var otpStatus: OTPStatus = .unknown {
        didSet {
            updateInputState()
        }
    }
    @Published var didAgree: Bool = false {
        didSet {
            updateInputState()
        }
    }
    @Published var canSubmit: Bool = false
    @Published var otp: String = "" {
        didSet {
            otpTextDidChange()
            updateInputState()
        }
    }
    @Published var allowPinRequest: Bool = false
    @Published var loading: Bool = false
    @Published var didSignup: Bool = false
    
    @Published var userNameStatus: InputStatus = .unverified
    @Published var emailStatus: InputStatus = .unverified
    @Published var phoneNumberStatus: InputStatus = .unverified
    
    private let apiService = OnboardService()
    private var autoRefreshTimer: DispatchSourceTimer?
    private var verifiedPin: String = ""
    
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
    
    func updateInputState() {
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
//        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
//        let username = username.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let hasName = !name.isEmpty
        let hasEmail = (emailStatus == .verified)  //!email.isEmpty
        let hasUserName = (userNameStatus == .verified)  //!username.isEmpty
        let hasPhoneNumber = (country != nil) && !phoneNumber.isEmpty
        
        var didVerify: Bool = true
        switch otpStatus {
        case .verified:
            didVerify = true

        default:
            didVerify = false
        }
        
        let canSubmit = hasName && hasEmail && hasUserName && hasPhoneNumber && didVerify && didAgree
        self.canSubmit = canSubmit
    }
    
    func switchCountry(with code: String) {
        let countryKit = CountryKit()
        self.country = countryKit.searchByIsoCode(code)
    }
    
    
    //MARK: - API Calls
    func requestOTP() async {
        
        //        self.otpStatus = .duration(2*60)
        //        self.allowPinRequest = false
        //        self.runTimer()
        
        
        guard let dialCode = country?.phoneCode
        else {
            AlertUtility.showErrorAlert(message: NSLocalizedString("profile.edit.error.number", comment: ""))
            return
        }
        
        let internationalNumber = "\(dialCode)\(phoneNumber)"
        let phoneKit = PhoneNumberKit()
        
        do {
            _ = try phoneKit.parse(internationalNumber) //Validating phone number
        }
        catch {
            AlertUtility.showErrorAlert(message: NSLocalizedString("profile.edit.error.number", comment: ""))
            return
        }
        
        self.loading = true
        
        
        let checkerRequest = CheckerRequest(userName: nil,
                                            email: nil,
                                            mobileNumber: self.phoneNumber,
                                            countryCode: "\(dialCode)")
        let checkerResult = await self.apiService.check(for: checkerRequest)
        switch checkerResult {
        case .success(_): break
        case .failure(let failure):
            switch failure {
            case .error(let error):
                if (error as NSError).code == 404 {
                    DispatchQueue.main.async {
                        AlertUtility.showErrorAlert(message: "Account exist with the provided mobile number.")
                    }
                }
                else {
                    DispatchQueue.main.async {
                        AlertUtility.showErrorAlert(message: error.localizedDescription)
                    }
                }
                
            default:
                DispatchQueue.main.async {
                    AlertUtility.showErrorAlert(message: failure.localizedDescription)
                }
            }
            self.loading = false
            return
        }
        
        
        
        let request = OTPRequest(input: self.phoneNumber,
                                 countryCode: "\(dialCode)",
                                 type: .register)
        
        let result = await self.apiService.requestOTP(with: request)
        
        switch result {
        case .success(let success):
            let response = success.result
            
            if !response.isUserExist {
                self.otpStatus = .duration(2*60)
                self.allowPinRequest = false
                self.runTimer()
            }
            else {
                DispatchQueue.main.async {
                    AlertUtility.showErrorAlert(message: "Account exist with the provided mobile number. ")
                }
            }
            
        case .failure(let failure):
            DispatchQueue.main.async {
                AlertUtility.showErrorAlert(message: failure.localizedDescription)
            }
        }
        
        self.loading = false
    }
    
    func verifyPin() async {
        if !verifiedPin.isEmpty, verifiedPin == otp {
            return
        }
        
        self.loading = true
        
        let request = OTPVerifyRequest(input: phoneNumber,
                                       countryCode: "\(country?.phoneCode ?? 0)",
                                       otp: otp)
        
        let result = await apiService.verifyRegisterOTP(with: request)//verifyOTP(with: request)
        switch result {
        case .success(_):
            self.stopTimer()
            self.otpStatus = .verified
            self.verifiedPin = self.otp
            
        case .failure(let failure):
            DispatchQueue.main.async {
                AlertUtility.showErrorAlert(message: failure.localizedDescription)
            }
        }
        
        self.loading = false
    }
    
    func onboard() async {
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        if name.isEmpty {
            AlertUtility.showErrorAlert(message: NSLocalizedString("profile.edit.error.name", comment: ""))
            return
        }
        
        if email.isEmpty || !EmailSyntaxValidator.correctlyFormatted(email) {
            AlertUtility.showErrorAlert(message: NSLocalizedString("profile.edit.error.email", comment: ""))
            return
        }
        
        switch otpStatus {
        case .verified: break
        default:
            AlertUtility.showErrorAlert(message: "Verify your mobile number")
            return
        }
                    
        self.loading = true
        
        let request = SignupRequest(userName: username,
                                    name: name,
                                    email: email,
                                    referralCode: referralCode.isEmpty ? nil : referralCode,
                                    mobileNumber: phoneNumber,
                                    countryCode: "\(country?.phoneCode ?? 0)",
                                    dob: birthDate?.toFormat("yyyy-MM-dd") ?? "")
                
        let result = await apiService.register(with: request)
        self.loading = false
        
        switch result {
        case .success(let success):
            let user = success.result
            self.saveDetail(user: user)
            
        case .failure(let failure):
            DispatchQueue.main.async {
                AlertUtility.showErrorAlert(message: failure.localizedDescription)
            }
        }
        
        
        
        //        guard let dialCode = country?.phoneCode
        //        else {
        //            SGAlertUtility.showErrorAlert(message: NSLocalizedString("profile.edit.error.number", comment: ""))
        //            return
        //        }
        //
        //        let internationalNumber = "\(dialCode)\(phoneNumber)"
        //        let phoneKit = PhoneNumberKit()
        //
        //        do {
        //            _ = try phoneKit.parse(internationalNumber) //Validating phone number
        //        }
        //        catch {
        //            SGAlertUtility.showErrorAlert(message: NSLocalizedString("profile.edit.error.number", comment: ""))
        //            return
        //        }
        
    }
    
    func verifyInput(of type: OnboardField) async {
        switch type {
        case .name:
            return
        case .emailAddress:
            await checkEmailAddress()
        case .birthDate:
            return
        case .phoneNumber:
            return
        case .otp:
            return
        case .userName:
            await checkUserName()
        case .code:
            return
        }
    }
    
    func checkUserName() async {
        let userName = self.username.trimmingCharacters(in: .whitespacesAndNewlines)
        if userName.isEmpty {
            self.userNameStatus = .unverified
//            DispatchQueue.main.async {
//                AlertUtility.showErrorAlert(message: NSLocalizedString("User name is empty", comment: ""))
//            }
            return
        }
        
        let request = CheckerRequest(userName: userName,
                                     email: nil,
                                     mobileNumber: nil,
                                     countryCode: nil)
        
        self.userNameStatus = .verifying
        let response = await self.checkInput(with: request)
        
        switch response {
        case .unverified: break
        case .verifying: break
        case .verified: break
        case .notAvailable:
            DispatchQueue.main.async {
                AlertUtility.showErrorAlert(message: NSLocalizedString("Account exist with the provided user name", comment: ""))
            }
        }
        self.userNameStatus = response
        self.updateInputState()
    }
    
    func checkEmailAddress() async {
        let emailAddress = self.email.trimmingCharacters(in: .whitespacesAndNewlines)
        if emailAddress.isEmpty {
            self.userNameStatus = .unverified
//            DispatchQueue.main.async {
//                AlertUtility.showErrorAlert(message: NSLocalizedString("User name is empty", comment: ""))
//            }
            return
        }
        
        let request = CheckerRequest(userName: nil,
                                     email: emailAddress,
                                     mobileNumber: nil,
                                     countryCode: nil)
        
        self.emailStatus = .verifying
        let response = await self.checkInput(with: request)
        
        switch response {
        case .unverified: break
        case .verifying: break
        case .verified: break
        case .notAvailable:
            DispatchQueue.main.async {
                AlertUtility.showErrorAlert(message: NSLocalizedString("Account exist with the provided email address", comment: ""))
            }
        }
        self.emailStatus = response
        self.updateInputState()
    }
    
    func checkMobileNumber() {
        
    }
    
    private func checkInput(with request: CheckerRequest) async -> InputStatus {
        let result = await self.apiService.check(for: request)
        switch result {
        case .success(_):
            return .verified
        case .failure(let failure):
            switch failure {
            case .error(let error):
                if (error as NSError).code == 404 {
                    return .notAvailable
                }
                else {
                    DispatchQueue.main.async {
                        AlertUtility.showErrorAlert(message: NSLocalizedString(failure.description, comment: ""))
                    }
                    return .unverified
                }
                
            default:
                DispatchQueue.main.async {
                    AlertUtility.showErrorAlert(message: NSLocalizedString(failure.description, comment: ""))
                }
                return .unverified
            }
        }
    }
}


private extension OnboardViewModel {
    func phoneInputDidChange() {
        otpStatus = .unknown
        stopTimer()
        updateInputState()
    }
    
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
    
    //    func saveDetail(user: UserDetail) {
    //        SGAppSession.shared.user.send(user)
    //        SGAppSession.shared.token = user.token
    //
    //        SGUserDefaultStorage.saveUserData(user: user)
    //        SGUserDefaultStorage.saveToken(token: user.token)
    //
    //        self.loading = true
    //        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {[weak self] in
    //            self?.loading = false
    //            self?.didSignup = true
    //        }
    //    }
}

private extension OnboardViewModel {
    func saveDetail(user: UserResponse) {
        
        AppSession.shared.userSubject.send(user)
    
        self.loading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {[weak self] in
            self?.loading = false
            self?.didSignup = true
        }
    }
}
