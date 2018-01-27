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
                StorageModel.saveUserData(model: login!)
                let data = StorageModel.getUserData()
                callback(true,Common.getString(text:response.message));
            } else {
                callback(false,Common.getString(text:response.message));
            }
            
        }
    }
    
    
    static func appRegisterUser(firstname:String,
                                lastname:String,
                                gender:String,
                                dateofbirth:String,
                                handphone:String,
                                email:String,
                                address1:String,
                                address2:String,
                                city:String,
                                postalcode:String,
                                profilePic:UIImage?,
                                callback: @escaping (Bool,String) -> Void)  {
        
    
        var profilePicData: Data?
        if let image = profilePic{
            profilePicData = UIImageJPEGRepresentation(image, 1.0)!
        }
        
        Common.showHud()
        var dictParam = Dictionary<String,Any>()
        dictParam["usertype"] = "App User"
        dictParam["firstname"] = firstname
        dictParam["lastname"] = lastname
        dictParam["gender"] = gender
        dictParam["dateofbirth"] = dateofbirth
        dictParam["handphone"] = handphone
        dictParam["email"] = email
        dictParam["address1"] = address1
        dictParam["address2"] = address2
        dictParam["city"] = city
        dictParam["postalcode"] = postalcode
        dictParam["profilepic"] = profilePicData
        dictParam["deviceid"] = "123"
        dictParam["gsmid"] = "123"
        dictParam["isfirsttimeuser"] = "True"
        dictParam["status"] = "True"
        

        Service.postRequest(endPoint: kServiceUrl+ServiceName.RIGISTER_USER.rawValue,params: dictParam) { (response) in
            Common.hideHud()
            if response.isSuccess(),let obj = response.data{
                let loginModel = LoginResponseDto()
                loginModel.userid = obj["id"] as? Int
                StorageModel.saveUserData(model: loginModel)
                let data = StorageModel.getUserData()
                callback(true,Common.getString(text:response.message));
            } else {
                callback(false,Common.getString(text:response.message));
                
            }
            
        }
    }
    
    
    static func requestOTP(OTP:String,callback: @escaping (Bool,String) -> Void)  {
        // { "userid": 1, "OTP": "1234", "OTPType": "R" }
        guard  let userid = StorageModel.getUserData()?.userid else {return}
        
        let dict = ["userid":String(userid),
                    "OTP":OTP,
                    "OTPType":"R"]
        Common.showHud()
        Service.postRequest(endPoint: kServiceUrl+ServiceName.VERIFY_OTP.rawValue,params: dict) { (response) in
            Common.hideHud()
            if response.isSuccess(),let obj = response.data{
                //                let json = JSON(response.data!)
                
                callback(true, response.message!);
            } else {
                callback(false,response.message!);
            }
            
        }
    }
    
    
    
    
}
