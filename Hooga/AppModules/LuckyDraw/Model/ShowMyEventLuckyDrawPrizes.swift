//
//  ShowMyEventLuckyDrawPrizes.swift
//  Hooga
//
//  Created by Nakul Singh on 2/5/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import Foundation
import ObjectMapper

class ShowMyEventLuckyDrawPrizes:NSObject,Mappable {
    
    var eventid : Int?
    var luckydrawprizeid : Int?
    var prizetitle : String?
    var prizedescription : String?
    var prizeworth: String?
    var prizeimage:String?
    
    override init() {
        
    }
    
    required init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        eventid            <- map["eventid"]
        luckydrawprizeid            <- map["luckydrawprizeid"]
        prizetitle        <- map["prizetitle"]
        prizedescription            <- map["prizedescription"]
        prizeworth <- map["prizeworth"]
        prizeimage <- map["prizeimage"]
    }
}



