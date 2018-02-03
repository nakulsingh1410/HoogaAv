//
//  BookingDetail.swift
//  Hooga
//
//  Created by @mrendra on 03/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit
import ObjectMapper

class BookingDetail: NSObject {
   
    var firstName : String!
    var lastName  : String!
    var gender : String!
    var  dob :String!
    var mobile : String!
    var email : String!
    var profilePic : String!
    var address1 : String!
    var address2 : String!
    var city : String!
    var postalCode  : String!
    var ticketId  : NSInteger!
    
    override init() {
        super.init()
        self.firstName = ""
        self.lastName  = ""
        self.gender = ""
        self.dob = ""
        self.email = ""
        self.address1 = ""
        self.address2 = ""
        self.profilePic = ""
        self.city = ""
        self.postalCode = ""
        self.mobile = ""
        ticketId = 0
    }
}


class SaveBookingDetail: NSObject,Mappable {
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
    var isearlybird : String?
    var status = "false"
    
    override init() {
      
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
        registrationid            <- map["registrationid"]
        isearlybird            <- map["isearlybird"]
    }
}


