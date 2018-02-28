//
//  QRCodeModel.swift
//  Hooga
//
//  Created by Nakul Singh on 2/6/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit
import ObjectMapper
class QRCodeRequestModel: NSObject,Mappable {
    
    var ticketid : Int?
    var eventID : Int?
    
    init(ticketId:Int,eventId:Int) {
        ticketid = ticketId
        eventID = eventId
    }
    
    required init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        ticketid            <- map["ticketid"]
        eventID            <- map["eventID"]
    }
}

class QRCodeTickets: NSObject,Mappable {
    
    var qrCodeID : Int?
    var qrCode : String?
    var qrCodeImage : String?
    var eventid : Int?
    var title : String?
    var startdate : String?
    var starttime : String?
    var ticketid : Int?
    var firstName : String?
    var lastName : String?
    var isearlybird : String?
    var tickettypeid : Int?
    var tickettype : String?
    var regularprice : String?
    var ticketimage : String?
    var earlybirdprice : String?
    
    required init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        qrCodeID            <- map["qrCodeID"]
        qrCode              <- map["qrCode"]
        qrCodeImage            <- map["qrCodeImage"]
         title            <- map["title"]
         startdate            <- map["startdate"]
         starttime            <- map["starttime"]
         ticketid            <- map["ticketid"]
         firstName            <- map["firstName"]
         lastName            <- map["lastName"]
         isearlybird            <- map["isearlybird"]
         tickettypeid            <- map["tickettypeid"]
         tickettypeid            <- map["tickettypeid"]
         tickettype            <- map["tickettype"]
         regularprice            <- map["regularprice"]
         ticketimage            <- map["ticketimage"]
         earlybirdprice            <- map["earlybirdprice"]
    }
}


