//
//  AddAccountViewModel.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 28/04/23.
//

import Foundation

class AddAccountViewModel: ObservableObject {
    @Published var locations    = [LocationPreference]()
    @Published var educations   = [EducationPreference]()
    @Published var grades       = [UnderGradePreference]()
    @Published var years        = [PostGradePreference]()
    @Published var mediums      = [MediumPreference]()
    @Published var boards       = [BoardPreference]()
    
    @Published var pickedLocation: LocationPreference? = nil
    @Published var pickedEducation: EducationPreference? = nil
    @Published var pickedGrade: UnderGradePreference? = nil
    @Published var pickedYear: PostGradePreference? = nil
    @Published var pickedMedium: MediumPreference? = nil
    @Published var pickedBoard: BoardPreference? = nil
    
    @Published var loading: Bool = false
    
    private let apiService = PreferenceService()
    
    
    @MainActor
    func fetchDetails() async {
        let locationRequest = LocationPreferenceRequest(start: 0, count: 100)
        let mediumRequest   = MediumPreferenceRequest(start: 0, count: 100)
        let boardRequest    = BoardPreferenceRequest(start: 0, count: 100)
        
        self.loading = true
        do {
            async let locations = apiService.getLocations(request: locationRequest)
            async let mediums   = apiService.getMediums(request: mediumRequest)
            async let boards    = apiService.getBoards(request: boardRequest)
            
//            let (fetchedLocations, fetchMediums, fetchedBoards) = try await (locations.rows, mediums.rows, boards.rows)
                        
            self.locations  = try await locations
            self.mediums    = try await mediums
            self.boards     = try await boards
            
            DispatchQueue.main.async {[weak self] in
                self?.loading = false
            }
//            print("Locations \(self.locations)")
//            print("mediums \(self.mediums)")
//            print("boards \(self.boards)")
        }
        catch {
            DispatchQueue.main.async {[weak self] in
                self?.loading = false
                AlertUtility.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func fetchEducations(for location:LocationPreference) async {
        let educationRequest = EducationPreferenceRequest(locationID: location.id, start: 0, count: 100)
        
        self.loading = true
        do {
            async let educations = apiService.getEducations(request: educationRequest)
            self.educations = try await educations.rows
            
            DispatchQueue.main.async {[weak self] in
                self?.loading = false
            }
        }
        catch {
            DispatchQueue.main.async {[weak self] in
                self?.loading = false
                AlertUtility.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func fetchGrades(for education:EducationPreference) async {
        
        if self.pickedEducation == education { return }
        
        self.loading = true
        do {
            if education.underGrades == true {
                let gradeRequest =  UnderGradesPreferenceRequest(educationID: education.id, start: 0, count: 100)
                async let response = apiService.getUnderGrades(request: gradeRequest)
                self.grades = try await response.rows
                self.years = []
            }
            else {
                let request = PostGradesPreferenceRequest(start: 0, count: 100)
                async let response = apiService.getPostGrades(request: request)
                self.years = try await response.rows
            }
                        
            DispatchQueue.main.async {[weak self] in
                self?.loading = false
            }
        }
        catch {
            DispatchQueue.main.async {[weak self] in
                self?.loading = false
                AlertUtility.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
}
