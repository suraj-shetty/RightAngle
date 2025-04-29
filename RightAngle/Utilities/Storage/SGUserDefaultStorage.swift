//
//  SGUserDefaultStorage.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 05/04/23.
//

import Foundation


class SGUserDefaultStorage: NSObject {
    static let KEY_USER_DATA = "kUserData"
    static let KEY_TOKEN   = "kToken"

    
    
    class func saveUserData(user: UserResponse){
        let encoder = JSONEncoder()
        do{
            let data = try encoder.encode(user)
            UserDefaults.standard.set(data, forKey: KEY_USER_DATA)
        }catch let encodeError {
            print("Encoder error ", encodeError)
        }
    }
    
    class func getUserData() -> UserResponse? {
        if let data = UserDefaults.standard.data(forKey: KEY_USER_DATA){
            do{
                let decoder = JSONDecoder()
                let user_data = try decoder.decode(UserResponse.self, from: data)
                return user_data
            }catch let parseError {
                print("User data parse error - ", parseError )
            }
        }
        
        return nil
    }
    
    class func saveToken(token: String) {
        UserDefaults.standard.set(token, forKey: KEY_TOKEN)
        UserDefaults.standard.synchronize()
    }
    
    class func getToken() -> String? {
        guard let token = UserDefaults.standard.string(forKey: KEY_TOKEN)
        else {
            return nil
        }

        return token
    }
    
    
    class func clearData(){
        UserDefaults.standard.removeObject(forKey: KEY_USER_DATA)

    }
}
