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
                if let dob = login?.dateofbirth{
                 login?.dateofbirth = dob.getDateString()
                }
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
                                address1:String?,
                                address2:String?,
                                city:String?,
                                postalcode:String?,
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
        
        
        Service.postRequestWithJsonResponse(endPoint: kServiceUrl+ServiceName.RIGISTER_USER.rawValue,params: dictParam) { (response) in
            Common.hideHud()
            
            if let obj = response.result.value as? [String:Any]{
                if let userId = obj["id"] as? Int,userId != 0{
                     let loginModel = LoginResponseDto()
                    loginModel.userid = userId
                    loginModel.email = email
                    loginModel.handphone = handphone
                    StorageModel.saveUserData(model: loginModel)
                    callback(true,"Success");
                }else{
                    if let message = obj["message"] as? String{
                        callback(false,message);
                    }
                }
            } else {
                callback(false,"");
            }
            
        }
    }
    
    
    static func requestOTP(OTP:String,OTPScreen:ComingFromScreen,callback: @escaping (Bool,String) -> Void)  {
        // { "userid": 1, "OTP": "1234", "OTPType": "R" }
        guard  let userid = StorageModel.getUserData()?.userid else {return}
        var optType = "R"
        if OTPScreen == ComingFromScreen.registration{
            optType = "R"
        }else if OTPScreen == ComingFromScreen.forgotPassword{
            optType = "F"
        }
        
        let dict = ["userid":String(userid),
                    "OTP":OTP,
                    "OTPType":optType] //
        Common.showHud()
        Service.postRequestWithJsonResponse(endPoint: kServiceUrl+ServiceName.VERIFY_OTP.rawValue,params: dict) { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let message = obj["Message"] as? String,message == "Success"{
                    callback(true,"");

                }else{
                    if let message = obj["Message"] as? String,message.length > 0{
                        callback(false,message);

                    }
                }
            } else {
                callback(false,"");
            }
            
        }
    }
    static func setPassword(password:String,callback: @escaping (Bool,String) -> Void)  {
        // { "userid": 1, "OTP": "1234", "OTPType": "R" }
        guard  let userid = StorageModel.getUserData()?.userid else {return}
        
        let dict = ["userid":String(userid),
                    "password":password,
                    "deviceid":"123",
                    "gsmid":""]
        Common.showHud()
        Service.postRequestWithJsonResponse(endPoint: kServiceUrl+ServiceName.SET_PASSWORD.rawValue,params: dict) { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let status = obj["Status"] as? String,status == "Success" {
                    callback(true,"");
                }else{
                    callback(false,"");
                }
            } else {
                if let obj = response.result.value as? [String:Any], let message = obj["Message"] as? String {
                    callback(false,message);
                }
                callback(false,"");
            }
            
        }
    }
    
    static func setForgotPassword(username:String,callback: @escaping (Bool,String) -> Void)  {
        //{ "userid": 1, "username": "sriram@mindmaster.com.sg" }
        //        guard  let userid = StorageModel.getUserData()?.userid else {return}
        
        let dict = ["username":username]
        Common.showHud()
        Service.postRequestWithJsonResponse(endPoint: kServiceUrl+ServiceName.VERIY_USER.rawValue,params: dict) { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let message = obj["Message"] as? String,message == "Success"{
                    if let userId = obj["userid"] as? Int,userId != 0{
                        let loginModel = LoginResponseDto()
                        loginModel.userid = userId
                        if username.isNumber() {
                            loginModel.handphone = username
                        }else{
                            loginModel.email = username
                        }
                        StorageModel.saveUserData(model: loginModel)
                        callback(true,"");
                    }else{
                        callback(false,message);
                    }
                } else {
                    if let message = obj["Message"] as? String,message.length > 0{
                        callback(false,message);
                    }else{
                        callback(false,"Error occured");
                    }
                }
            }else{
                callback(false,"Error occured");
            }
        }
    }
    
    
    static func getMyProfile(callback: @escaping (Bool,String) -> Void)  {
        guard  let userid = StorageModel.getUserData()?.userid else {return}
        let dict = ["userid":userid]
        Common.showHud()
        Service.postRequest(endPoint: kServiceUrl+ServiceName.DISPLAY_MY_PROFILE.rawValue,params: dict) { (response) in
            Common.hideHud()
            if response.isSuccess(),let obj = response.data{
                let login = LoginResponseDto(map: obj)
                if let dob = login?.dateofbirth{
                    login?.dateofbirth = dob.getDateString()
                }
                StorageModel.saveUserData(model: login!)
                callback(true,Common.getString(text:response.message));
            } else {
                callback(false,Common.getString(text:response.message));
            }
            
        }
    }
    static func updateMyProfile(firstname:String,
                                lastname:String,
                                gender:String,
                                dateofbirth:String,
                                handphone:String,
                                email:String,
                                address1:String?,
                                address2:String?,
                                city:String?,
                                postalcode:String?,
                                profilePic:UIImage?,
                                callback: @escaping (Bool,String) -> Void)  {
        
        
        var profilePicData: Data?
        if let image = profilePic{
            profilePicData = UIImageJPEGRepresentation(image, 1.0)!
        }
        
        guard  let userid = StorageModel.getUserData()?.userid else {return}

        
        Common.showHud()
        var dictParam = Dictionary<String,Any>()
        dictParam["userid"] = userid
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
        
        
        Common.showHud()
        Service.postRequestWithJsonResponse(endPoint: kServiceUrl+ServiceName.UPDATE_MY_PROFILE.rawValue,params: dictParam) { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let message = obj["message"] as? String,message.length > 0{
                    callback(false,message);
                }else{
                    getMyProfile(callback: { (flag, message) in
                        if flag {
                            callback(true,"");
                        }else{
                             callback(false,"");
                        }
                    })
                    
                }
            } else {
                callback(false,"");
            }
            
        }
    }
    
    
    
}
