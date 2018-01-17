//
//  ServiceManager.swift
//  T-Kart
//
//  Created by Nakul Singh on 10/31/17.
//  Copyright © 2017 Nakul Singh. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
let kNoResponse = "No response"
class Service : NSObject{
    
    private static func setHeader(_ isMultipart:Bool = false) -> [String : String] {
        var dic = [
            "Accept"        : "application/json",
            "token"         :  "",
            ];
        if !isMultipart {
            dic["Content-Type"] = "application/x-www-form-urlencoded"
        }
        return dic;
    }
    
    static func getRequest(endPoint: String, params:[String : Any] = [:], callback: @escaping (ResponseDto) -> Void) {
        print(endPoint)
        print(params)
        if Common.isConnectedToNetwork() {
            Alamofire.request(endPoint, method: .get, parameters: params, encoding: URLEncoding.default, headers: setHeader()).responseJSON(completionHandler: { (response) in
                //                print(response.result.value ?? String(data: response.data!, encoding: .utf8) ?? kNoResponse)
                requestCallBack(result: response.result, callback: callback);
            })
            
        }else{
            callback(ResponseDto(internetAvailable: true, message: MessageError.INTERNET_ERROR.rawValue));
        }
    }
    
    static func postRequest(endPoint: String, params: [String : Any], callback: @escaping (ResponseDto) -> Void) {
        //  let _params = getDefaultParams(params: params)
        print(params)
        print(endPoint)
        if Common.isConnectedToNetwork(){
            Alamofire.request(endPoint, method: .post, parameters: params, encoding: URLEncoding.default, headers: setHeader()).responseJSON(completionHandler: { (response) in
                print(response.result.value ?? String(data: response.data!, encoding: .utf8) ?? kNoResponse)
                requestCallBack(result: response.result, callback: callback);
            })
        }else{
            callback(ResponseDto(internetAvailable: true, message: MessageError.INTERNET_ERROR.rawValue));
        }
    }
    
    static func requestCallBack(result: Result<Any>, callback: (ResponseDto) -> Void) {
        if(result.isSuccess){
            if let dic = result.value as? [String : Any]{
                let res = Mapper<ResponseDto>().map(JSON: dic)!
                print(res)
                callback(res);
                return
            }
        }
        callback(ResponseDto(message: result.error?.localizedDescription ?? "Something went wrong!"));
    }
    
    //MARK: - UPLOAD MEDIA IN MULTIPART
    static func uploadRequest(endPoint: String, params : [String : Any], fileParams:[String : Any]?,callback: @escaping (ResponseDto) -> Void) {
        print(endPoint)
        print(params)
        
        let URL = try! URLRequest(url: endPoint, method: .post, headers: setHeader(true))
        upload(multipartFormData: { (multipartFormData) in
            for (key, value) in params {
                if let stringValue = value as? String {
                    multipartFormData.append(stringValue.data(using: String.Encoding.utf8)!,withName: key)
                }else{
                    multipartFormData.append(String(describing: value).data(using: String.Encoding.utf8)!, withName: key)
                }
                
            }
            if let fileParams = fileParams {
                for (key, value) in fileParams {
                    if value is Data {
                        multipartFormData.append(value as! Data, withName: key, fileName: "image.png", mimeType: "image/png")
                    }
                }
            }
        }, with: URL, encodingCompletion: { (result) in
            
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print(response.result.value ?? String(data: response.data!, encoding: .utf8) ?? "No response")
                    requestCallBack(result: response.result, callback: callback);
                }
            case .failure(let encodingError):
                print(encodingError)
            }
            
        })
    }
    
    //    static func getDefaultParams(params:[String:Any])-> [String:Any]{
    //        var _params = params;
    //        _params["device_type"] = "IOS"
    //        if let token = UserDefaults.standard.get(key: kStringPushToken){
    //            _params["device_id"] = token
    //        }else{
    //            _params["device_id"] = "123"
    //
    //        }
    //        return _params;
    //    }
    
}
