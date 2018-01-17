//
//  StorageModel.swift
//  Hooga
//
//  Created by Nakul Singh on 1/14/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import Foundation

class StorageModel {
    
    func saveUserData(model:LoginResponseDto?)  {
        if let dataModel = model {
            let userDefaults = UserDefaults.standard
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: dataModel)
            userDefaults.set(encodedData, forKey: kUserInfo)
            userDefaults.synchronize()
        }
       
    }
    
    func getUserData() ->LoginResponseDto? {
        let userDefaults = UserDefaults.standard
        if let decoded  = userDefaults.object(forKey: kUserInfo) as? Data {
            let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? LoginResponseDto
            return decodedTeams
        }
        return nil
    }
}
