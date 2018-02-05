//
//  ShowMyEventLuckyDraw.swift
//  Hooga
//
//  Created by Nakul Singh on 2/5/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import Foundation
import ObjectMapper

class ShowMyEventLuckyDraw:NSObject,Mappable {
    
    var eventid : Int?
    var luckydrawid : Int?
    var entrydeadline : String?
    var location : String?
    var conductedby: String?
    var heldon:String?

    required init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        eventid            <- map["eventid"]
        luckydrawid            <- map["luckydrawid"]
        entrydeadline        <- map["entrydeadline"]
        location            <- map["location"]
        conductedby <- map["conductedby"]
        heldon <- map["heldon"]
    }
}



