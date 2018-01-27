//
//  EventListingModel.swift
//  Hooga
//
//  Created by Nakul Singh on 1/27/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import Foundation
import ObjectMapper

class CategoryModel: NSObject,Mappable {
    var category : String?
    var categoryid : Int?
    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        category            <- map["category"]
        categoryid         <- map["categoryid"]
    }
    
    
}

/*************************************************************/
class EntryTypes: NSObject,Mappable {
    var entrytype : String?
    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        entrytype            <- map["entrytype"]
    }
    
    
}

/*************************************************************/
class Tags: NSObject,Mappable {
    var tagid : Int?
    var tag : String?
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        tagid            <- map["tagid"]
        tag              <- map["tag"]
    }
    
    
}

/*************************************************************/
class Events: NSObject,Mappable {
    var categoryid : Int?
    var category : String?
    var entrytype : String?
    var eventid : String?
    var title : String?
    var eventcode : String?
    var startdate : String?
    var starttime : String?
    var bannerimage : String?

    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        categoryid            <- map["categoryid"]
        category              <- map["category"]
        entrytype              <- map["entrytype"]
        eventid              <- map["eventid"]
        title                <- map["title"]
        eventcode              <- map["eventcode"]
        startdate              <- map["startdate"]
        starttime              <- map["starttime"]
        bannerimage              <- map["bannerimage"]

    }
    

}


