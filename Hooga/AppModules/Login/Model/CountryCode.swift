//
//  CountryCode.swift
//  Hooga
//
//  Created by Nakul Singh on 2/25/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit
import ObjectMapper

class CountryCode: NSObject,Mappable {
    
    var Country : String?
    var Code : String?

    override init() {
        
    }
    required init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        Country  <- map["Country"]
        Code      <- map["Code"]
    }
}



