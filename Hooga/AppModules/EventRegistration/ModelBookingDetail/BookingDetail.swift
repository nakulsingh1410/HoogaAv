//
//  BookingDetail.swift
//  Hooga
//
//  Created by @mrendra on 03/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit
import ObjectMapper

class EventRecord: NSObject {
    
    var eventDetail:EventDetail?
    var ticketTypeDetails:TicketTypeDetails?
    var availableEarlyBirdTicketsCount:Int = 0
    var selectedTicketType : TicketType?
    var quantityTicket = 0
    
    
    override init() {
        super.init()
        
    }
}

class SaveBookingDetail: NSObject,Mappable {
    
    //This is a  local  variable
    var ticketId  : Int?
    
    var eventid : Int?
    var tickettypeid : Int?
    var registrationid : Int?
    var tickettype : String?
    
    var firstname : String?
    var lastname : String?
    var gender : String?
    var dateofbirth : String?
    var handphone : String?
    var email : String?
    var address1 : String?
    var address2 : String?
    var city : String?
    var postalcode : String?
    var profilepic : String?
    
    var isearlybird : String = "false"
    var status = "false"
    
    override init() {
      super.init()
        self.address1 = ""
        self.address2 = ""
        self.city =  ""
        self.dateofbirth = ""
        self.email    = ""
        self.eventid = 0
        self.firstname = ""
        self.gender = ""
        self.handphone = ""
        self.postalcode = ""
        self.profilepic = ""
        self.registrationid = 0
        self.ticketId = 0
        self.tickettype = ""
        self.tickettypeid = 0
        self.dateofbirth = ""
        self.isearlybird = ""
        
    }
    
    required init?(map: Map) {
 
    }
    
    public func mapping(map: Map) {
        eventid            <- map["eventid"]
        tickettypeid            <- map["tickettypeid"]
        registrationid            <- map["registrationid"]
        tickettype            <- map["tickettype"]
        firstname            <- map["firstname"]
        lastname            <- map["lastname"]
        gender            <- map["gender"]
        dateofbirth            <- map["dateofbirth"]
        handphone            <- map["handphone"]
        email            <- map["email"]
        address1            <- map["address1"]
        address2            <- map["address2"]
        city            <- map["city"]
        postalcode            <- map["postalcode"]
        profilepic            <- map["profilepic"]
        isearlybird            <- map["isearlybird"]
        status            <- map["status"]
        
    }
    
}

class BookingDetailResponse: NSObject,Mappable {
    
            var ticketid : Int?
            var tickettypeid : Int?
            var eventid : Int?
            var registrationid : Int?
            var isearlybird: String?
    
    required init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        eventid            <- map["eventid"]
        tickettypeid            <- map["tickettypeid"]
        registrationid        <- map["registrationid"]
        isearlybird            <- map["isearlybird"]
    }
}


