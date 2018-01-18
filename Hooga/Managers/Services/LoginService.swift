//
//  LoginService.swift
//  Hooga
//
//  Created by Nakul Singh on 1/14/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import Foundation

import Foundation
import SwiftyJSON
import ObjectMapper

class LoginService{
    
//    static func loginUser( callback: @escaping (Bool, HomeDataModel?,String) -> Void)  {
//        Common.showHud()
//        Service.getRequest(endPoint: kServiceUrl+ServiceName.HOME_FEDD.rawValue) { (response) in
//            if(response.isSuccess()){
//                let json = JSON(response.data!)
//                callback(true,Mapper<HomeDataModel>().map(JSON: json.object as! [String : Any]), response.message!);
//            } else {
//                callback(false, nil,response.message!);
//            }
//            Common.hideHud()
//        }
//    }
    
    static func loginUser(username:String, password:String,callback: @escaping (Bool,String) -> Void)  {
        
        let dict = ["username":username,
                    "password":password]
        Common.showHud()
        Service.postRequest(endPoint: kServiceUrl+ServiceName.LOGIN.rawValue,params: dict) { (response) in
             Common.hideHud()
            if response.isSuccess(),let obj = response.data{
//                let json = JSON(response.data!)
                let login = LoginResponseDto(map: obj)
                StorageModel().saveUserData(model: login!)
                let data = StorageModel().getUserData()
                callback(true, response.message!);
            } else {
                callback(false,response.message!);
            }
           
        }
    }
    
    
    
    
}
