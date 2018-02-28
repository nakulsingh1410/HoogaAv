//
//  ErrorBookingDetails.swift
//  Hooga
//
//  Created by Nakul Singh on 3/1/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit
import ObjectMapper

class ErrorBookingDetails: NSObject ,Mappable {

    var ErrorMessage: String?
    override init() {
        
    }
    required init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        ErrorMessage  <- map["ErrorMessage"]
        
    }
}
