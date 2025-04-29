//
//  OnboardServices.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 01/04/23.
//

import Foundation
import Combine

enum OnboardEndPoint: APIEndPoint {
    case signup(request: SignupRequest)
    case socialSignin(request: SocialSignInRequest)
    case checker(request: CheckerRequest)
    case requestPin(request: OTPRequest)
    case verifyPin(request: OTPVerifyRequest)
    
    var url: String {
        return "https://api.student.dev.rightangle.education/api/v1"
    }
    
    var path: String {
        switch self {
        case .signup:
            return "/signup"
        case .socialSignin:
            return "/signup"
        case .checker:
            return "/checker"
        case .requestPin:
            return "/send-otp"
        case .verifyPin:
            return "/verify-otp"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .signup:
            return .post
        case .socialSignin:
            return .post
        case .checker:
            return .post
        case .requestPin:
            return .post
        case .verifyPin:
            return .post
        }
    }
    
    var headers: [String : Any]? {
        return ["Content-Type": "application/json"]
    }
    
    var body: [String : Any]? {
        switch self {
        case .signup(let request):
            return request.dictionary
        case .socialSignin(let request):
            return request.dictionary
        case .checker(let request):
            return request.dictionary
        case .requestPin(let request):
            return request.dictionary
        case .verifyPin(let request):
            return request.dictionary
        }
    }
}

class OnboardService: NSObject, HTTPClient {
    func register(with request: SignupRequest) async -> Result<UserResult, APIError> {
        return await sendRequest(endpoint: OnboardEndPoint.signup(request: request),
                                 responseModel: UserResult.self)
    }
    
    func socialLogin(with request: SocialSignInRequest) async -> Result<UserResult, APIError> {
        return await sendRequest(endpoint: OnboardEndPoint.socialSignin(request: request),
                                 responseModel: UserResult.self)
    }
    
    func requestOTP(with request: OTPRequest) async -> Result<OTPResult, APIError> {
        return await sendRequest(endpoint: OnboardEndPoint.requestPin(request: request),
                                 responseModel: OTPResult.self)
    }
    
    func verifyOTP(with request: OTPVerifyRequest) async -> Result<UserResult, APIError> {
        return await sendRequest(endpoint: OnboardEndPoint.verifyPin(request: request),
                                 responseModel: UserResult.self)
    }
    
    func verifyRegisterOTP(with request: OTPVerifyRequest) async -> Result<OTPResult, APIError> {
        return await sendRequest(endpoint: OnboardEndPoint.verifyPin(request: request),
                                 responseModel: OTPResult.self)
    }
    
    
    func check(for request: CheckerRequest) async -> Result<MessageResult, APIError> {
        return await sendRequest(endpoint: OnboardEndPoint.checker(request: request),
                                 responseModel: MessageResult.self)
    }
}
