//
//  ParticipateModel.swift
//  Hooga
//
//  Created by Nakul Singh on 2/6/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import Foundation
import ObjectMapper

class ShowMyTicketDetails: NSObject,Mappable {
    
    var ticketid : Int?
    var eventid : Int?
    var firstName : String?
    var lastName : String?
    var tickettype : String?
    var eventname : String?
    var luckydrawsequence : String?
    
    required init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        ticketid            <- map["ticketid"]
        eventid            <- map["eventid"]
        firstName            <- map["firstName"]
        lastName            <- map["lastName"]
        tickettype            <- map["tickettype"]
        eventname            <- map["eventname"]
        luckydrawsequence            <- map["luckydrawsequence"]
    }
}

///////

class GenerateLuckyDrawNumber: NSObject,Mappable {
    
    var ticketid : Int?
    var luckydrawsequence : String?
    
    required init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        ticketid            <- map["ticketid"]
        luckydrawsequence            <- map["luckydrawsequence"]
    }
}
//////


class ShowMyEventLuckyDrawResult: NSObject,Mappable {
    
    var eventid : Int?
    var ticketid : Int?
    var luckydrawsequence : String?
    var firstName : String?
    var lastName : String?
    var isprizewon : String?
    var luckydrawprize : String?
    var isprizecollected : String?
    var collectedby : String?
    var collectedon : String?
    
    required init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        ticketid            <- map["ticketid"]
        eventid            <- map["eventid"]
        luckydrawsequence            <- map["luckydrawsequence"]
        firstName            <- map["firstName"]
        lastName            <- map["lastName"]
        isprizewon            <- map["isprizewon"]
        luckydrawprize            <- map["luckydrawprize"]
        luckydrawsequence            <- map["luckydrawsequence"]
        collectedby            <- map["collectedby"]
        collectedon            <- map["collectedon"]
        isprizecollected  <- map["isprizecollected"]

    }
}




