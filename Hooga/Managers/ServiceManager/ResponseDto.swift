//
//  Response.swift
//  Connect2Student
//
//  Created by dotsquares on 7/14/16.
//  Copyright © 2016 Dotsquares. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class ResponseDto:  Mappable {
    
    var status: String?
    var data: Map?
    var message: String?
    var internetAvailable = true
    
    func isSuccess() -> Bool {
        return status != nil && status != nil
    }
    
    init() {
    }
    
    init(status: String? = nil
        , internetAvailable: Bool = true
        , data: Map? = nil
        , message: String? = nil) {
        
        self.status = status
        self.data = data
        self.message = message
    }
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        data = map
    }
    let transform = TransformOf<Bool, String>(fromJSON: { (value: String?) -> Bool? in
        // transform value from String? to Int?
        return (value == "true" || value == "1") ? true : false
    }, toJSON: { (value: Bool?) -> String? in
        // transform value from Int? to String?
        if let value = value {
            return value == true ? "1" : "0"
        }
        return nil
    })
}
