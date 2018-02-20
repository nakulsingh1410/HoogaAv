//
//  TicketBooking.swift
//  Hooga
//
//  Created by Nakul Singh on 2/3/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit
import ObjectMapper

class TicketType: NSObject,Mappable {
    
    var tickettypeid : Int?
    var tickettype : String?
    
    
    override init() {
        
    }
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        tickettypeid           <- map["tickettypeid"]
        tickettype           <- map["tickettype"]
        
    }
    
}

class TicketTypeDetails: NSObject,Mappable {
    
    var tickettypeid : Int?
    var tickettype : String?
    var tickettypeorder :String?
    var maxticketslimit :String?
    var regularprice :String?
    var ticketimage :String?
    var ticketBooingDescription :String?
    var earlybirdticketslimit :String?
    var earlybirdprice :String?
    var Message :String?
    
    
    override init() {
        
    }
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        tickettypeid             <- map["tickettypeid"]
        tickettype               <- map["tickettype"]
        tickettypeorder           <- map["tickettypeorder"]
        maxticketslimit           <- map["maxticketslimit"]
        regularprice              <- map["regularprice"]
        ticketimage                <- map["ticketimage"]
        ticketBooingDescription    <- map["description"]
        earlybirdticketslimit      <- map["earlybirdticketslimit"]
        earlybirdprice             <- map["earlybirdprice"]
        Message                   <- map["Message"]
        earlybirdprice            <- map["earlybirdprice"]
        
    }

}

