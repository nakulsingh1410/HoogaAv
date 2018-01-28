//
//  EventService.swift
//  Hooga
//
//  Created by Nakul Singh on 1/27/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import Foundation
import ObjectMapper

class EventService {
    
    static func getCategories(callback: @escaping (Bool,[CategoryModel]?) -> Void){
        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.SHOW_CATEGORIES.rawValue
        Service.postRequestWithJsonResponse(endPoint: kServerUrl, params: [:])  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let EntryTypes = obj["categories"] as? [[String : Any]]{
                    let array = Mapper<CategoryModel>().mapArray(JSONArray:EntryTypes )
                    callback(true,array);
                }else{
                    callback(false,nil);
                }
            }else {
                callback(false,nil);
            }
            
        }
    }
    
    
    static func getEntryTypes(callback: @escaping (Bool,[EntryTypes]?) -> Void){
        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.SHOW_ENTRY_TYPES.rawValue
        Service.postRequestWithJsonResponse(endPoint: kServerUrl, params: [:])  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let EntryTypes = obj["EntryTypes"] as? [[String : Any]]{
                    let array = Mapper<EntryTypes>().mapArray(JSONArray:EntryTypes )
                    callback(true,array);
                }else{
                    callback(false,nil);
                }
            } else {
                callback(false,nil);
            }
        }
    }
    
    static func getFillTagsList(callback: @escaping (Bool,[Tags]?) -> Void){
        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.Fill_TAGS_LIST.rawValue
        Service.postRequestWithJsonResponse(endPoint: kServerUrl, params: [:])  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let EntryTypes = obj["Tags"] as? [[String : Any]]{
                    let array = Mapper<Tags>().mapArray(JSONArray:EntryTypes )
                    callback(true,array);
                }else{
                    callback(false,nil);
                }
            }else {
                callback(false,nil);
            }
            
        }
    }
    static func getEventList(categoryid:Int,
                             entrytype:String,
                             tag:String,
                             callback: @escaping (Bool,[Events]?) -> Void){
        
        var dictParam = Dictionary<String,Any>()
        dictParam["categoryid"] = categoryid
        dictParam["entrytype"] = entrytype
        dictParam["tag"] = tag
        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.ON_GOING_EVENTS.rawValue
        Service.postRequestWithJsonResponse(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let EntryTypes = obj["EventsList"] as? [[String : Any]]{
                    let array = Mapper<Events>().mapArray(JSONArray:EntryTypes )
                    callback(true,array);
                }else{
                    callback(false,nil);
                }
            }else {
                callback(false,nil);
            }
            
        }
    }
    
    
    
    
    
}
