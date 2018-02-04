//
//  EventDetailModel.swift
//  Hooga
//
//  Created by Nakul Singh on 1/29/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import Foundation
import ObjectMapper

class EventDetail: NSObject,Mappable {
    
    var eventid : Int?
    var categoryid : Int?
    var category : String?
    var entrytype : String?
    var title : String?
    var eventcode : String?
    var shortdescription : String?
    var longdescription : String?
    var startdate : String?
    var enddate : String?
    var starttime : String?
    var endtime : String?
    var duration : String?
    var numberofprizes : String?
    var eventlocation : String?
    var organizeridvar : Int?
    var organizer : String?
    var organizerphone : String?
    var organizeremail : String?
    var eventlogo : String?
    var bannerimage : String?
    var iseventcompleted : String?
    var regid : Int?
    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        eventid             <- map["eventid"]
        categoryid          <- map["categoryid"]
        category            <- map["category"]
        entrytype           <- map["entrytype"]
        title               <- map["title"]
        eventcode           <- map["eventcode"]
        shortdescription    <- map["shortdescription"]
        longdescription     <- map["longdescription"]
        startdate           <- map["startdate"]
        enddate             <- map["enddate"]
        starttime           <- map["starttime"]
        endtime             <- map["endtime"]
        duration            <- map["duration"]
        numberofprizes      <- map["numberofprizes"]
        eventlocation       <- map["eventlocation"]
        organizeridvar      <- map["organizeridvar"]
        organizer           <- map["organizer"]
        organizerphone      <- map["organizerphone"]
        organizeremail      <- map["organizeremail"]
        eventlogo           <- map["eventlogo"]
        bannerimage         <- map["bannerimage"]
        iseventcompleted    <- map["iseventcompleted"]
        regid               <- map["regid"]
    }
}

/*************************************************************/
class EventAssets: NSObject,Mappable {
    var assetid : Int?
    var mediatype : String?
    var assettype : String?
    var title : String?
    var path : String?
    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        assetid            <- map["assetid"]
        mediatype            <- map["mediatype"]
        assettype            <- map["assettype"]
        title            <- map["title"]
        path            <- map["path"]
    }
    
}


/*************************************************************/
class EventPlatform: NSObject,Mappable {
    var socialplatformid : Int?
    var platform : String?
    var url : String?
    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        socialplatformid            <- map["socialplatformid"]
        platform            <- map["platform"]
        url            <- map["url"]
        
    }
    
}


/*************************************************************/
class EventFAQ: NSObject,Mappable {
    var faqid : Int?
    var heading : String?
    var question : String?
    var answer : String?

    required init?(map: Map) {
        
    }
    public func mapping(map: Map) {
        faqid            <- map["faqid"]
        heading            <- map["heading"]
        question           <- map["question"]
        answer            <- map["answer"]

    }
}


/*************************************************************/
class EventTersmNCondition: NSObject,Mappable {
    var termid : Int?
    var termtitle : String?
    var termdescription : String?
    
    required init?(map: Map) {
        
    }
    public func mapping(map: Map) {
        termid            <- map["termid"]
        termtitle            <- map["termtitle"]
        termdescription            <- map["termdescription"]
        
    }
}



