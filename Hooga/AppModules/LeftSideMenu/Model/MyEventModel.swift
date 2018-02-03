//
//  MyEventModel.swift
//  Hooga
//
//  Created by Nakul Singh on 2/1/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit
import ObjectMapper
class MyEventModel: NSObject,Mappable {

    var userid : Int?
    var eventid : Int?
    var registrationid : Int?
    var registrationnumber : String?
    var categoryid : Int?
    var category : String?
    var entrytype : String?
    var eventcode : String?
    var title : String?
    var startdate : String?
    var starttime : String?
    var bannerimage : String?
    
    override init() {
        
    }
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        userid           <- map["userid"]
        eventid           <- map["eventid"]
        registrationid           <- map["registrationid"]
        registrationnumber           <- map["registrationnumber"]
        categoryid           <- map["categoryid"]
        category           <- map["category"]
        entrytype           <- map["entrytype"]
        eventcode           <- map["eventcode"]
        title           <- map["title"]
        startdate           <- map["startdate"]
        starttime           <- map["starttime"]
        bannerimage           <- map["bannerimage"]
    }
    
}
