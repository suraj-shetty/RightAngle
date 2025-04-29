//
//  PreferenceServices.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 28/04/23.
//

import Foundation
import Combine

enum PreferenceEndPoint: APIEndPoint {
    case locations(LocationPreferenceRequest)
    case educations(EducationPreferenceRequest)
    case underGrades(UnderGradesPreferenceRequest)
    case postGrades(PostGradesPreferenceRequest)
    case medium(MediumPreferenceRequest)
    case board(BoardPreferenceRequest)
    
    var url: String {
        return "https://api.student.dev.rightangle.education/api/v1"
    }
    
    var path: String {
        switch self {
        case .locations:    return "/content/location"
        case .educations:   return "/content/education"
        case .underGrades:  return "/content/grade"
        case .postGrades:   return "/content/year"
        case .medium:       return "/content/medium"
        case .board:        return "/content/board"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var headers: [String : Any]? {
        var requestHeaders = ["Content-Type": "application/json"]
        
        if let token = SGUserDefaultStorage.getToken(), !token.isEmpty {
            requestHeaders["Authorization"] = "Bearer \(token)"
        }
        
        return requestHeaders
    }
    
    var body: [String : Any]? {
        switch self {
        case .locations(let request):   return request.dictionary
        case .educations(let request):  return request.dictionary
        case .underGrades(let request): return request.dictionary
        case .postGrades(let request):  return request.dictionary
        case .medium(let request):      return request.dictionary
        case .board(let request):       return request.dictionary
        }
    }
}


class PreferenceService: NSObject, HTTPClient {
    func getLocations(request: LocationPreferenceRequest) async throws -> [LocationPreference] {
        do {
            let result = try await generateRequest(endpoint: PreferenceEndPoint.locations(request),
                                                   responseModel: LocationResult.self)
            return result.result
        }
        catch let error as APIError{
            throw error
        }
        catch {
            throw APIError.error(error)
        }
    }
    
    func getEducations(request: EducationPreferenceRequest) async throws -> EducationList {
        do {
            let result = try await generateRequest(endpoint: PreferenceEndPoint.educations(request),
                                                   responseModel: EducationResult.self)
            return result.result
        }
        catch let error as APIError{
            throw error
        }
        catch {
            throw APIError.error(error)
        }
    }
    
    func getUnderGrades(request: UnderGradesPreferenceRequest) async throws -> UnderGradeList {
        do {
            let result = try await generateRequest(endpoint: PreferenceEndPoint.underGrades(request),
                                                   responseModel: UnderGradeResult.self)
            return result.result
        }
        catch let error as APIError{
            throw error
        }
        catch {
            throw APIError.error(error)
        }
    }
    
    func getPostGrades(request: PostGradesPreferenceRequest) async throws -> PostGradeList {
        do {
            let result = try await generateRequest(endpoint: PreferenceEndPoint.postGrades(request),
                                                   responseModel: PostGradeResult.self)
            return result.result
        }
        catch let error as APIError{
            throw error
        }
        catch {
            throw APIError.error(error)
        }
    }
    
    func getMediums(request: MediumPreferenceRequest) async throws -> [MediumPreference] {
        do {
            let result = try await generateRequest(endpoint: PreferenceEndPoint.medium(request),
                                                   responseModel: MediumResult.self)
            return result.result
        }
        catch let error as APIError{
            throw error
        }
        catch {
            throw APIError.error(error)
        }
    }
    
    func getBoards(request: BoardPreferenceRequest) async throws -> [BoardPreference] {
        do {
            let result = try await generateRequest(endpoint: PreferenceEndPoint.board(request),
                                                   responseModel: BoardResult.self)
            return result.result
        }
        catch let error as APIError{
            throw error
        }
        catch {
            throw APIError.error(error)
        }
    }
}
