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
    /***************************************************************/
    //MARK: Event Listing Apis
    /***************************************************************/
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
/***************************************************************/
//MARK: Event Details Apis
/***************************************************************/
extension EventService{
    
    static func getEventDetail(eventid:Int,
                             callback: @escaping (Bool,EventDetail?) -> Void){
        
        var dictParam = Dictionary<String,Any>()
        dictParam["eventid"] = eventid

        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.SHOW_EVENT_DETAIL.rawValue
        Service.postRequestWithJsonResponse(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                let eventDetail = Mapper<EventDetail>().map(JSON: obj)
                callback(true,eventDetail);
            }else {
                callback(false,nil);
            }
            
        }
    }
    static func getEventAssets(eventid:Int,
                               callback: @escaping (Bool,[EventAssets]?) -> Void){
        
        var dictParam = Dictionary<String,Any>()
        dictParam["eventid"] = eventid
        
        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.SHOW_EVENT_ASSETS.rawValue
        Service.postRequestWithJsonResponse(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let arrObj = obj["Asserts"] as? [[String : Any]]{
                    let array = Mapper<EventAssets>().mapArray(JSONArray:arrObj )
                    callback(true,array);
                }else{
                    callback(false,nil);
                }
            }else {
                callback(false,nil);
            }
            
        }
    }
    
    static func getEventPlatform(eventid:Int,
                               callback: @escaping (Bool,[EventPlatform]?) -> Void){
        
        var dictParam = Dictionary<String,Any>()
        dictParam["eventid"] = eventid
        
        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.SHOW_EVENT_Platform.rawValue
        Service.postRequestWithJsonResponse(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let arrObj = obj["Platforms"] as? [[String : Any]]{
                    let array = Mapper<EventPlatform>().mapArray(JSONArray:arrObj )
                    callback(true,array);
                }else{
                    callback(false,nil);
                }
            }else {
                callback(false,nil);
            }
            
        }
    }
    
    static func getEventFAQ(eventid:Int,
                               callback: @escaping (Bool,[EventFAQ]?) -> Void){
        
        var dictParam = Dictionary<String,Any>()
        dictParam["eventid"] = eventid
        
        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.SHOW_EVENT_FAQs.rawValue
        Service.postRequestWithJsonResponse(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let arrObj = obj["FAQs"] as? [[String : Any]]{
                    let array = Mapper<EventFAQ>().mapArray(JSONArray:arrObj )
                    callback(true,array);
                }else{
                    callback(false,nil);
                }
            }else {
                callback(false,nil);
            }
            
            
        }
    }
    
    
    static func getEventTermsConditions(eventid:Int,
                            callback: @escaping (Bool,[EventTersmNCondition]?) -> Void){
        
        var dictParam = Dictionary<String,Any>()
        dictParam["eventid"] = eventid
        
        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.SHOW_EVENT_TERSM_CONDITION.rawValue
        Service.postRequestWithJsonResponse(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let arrObj = obj["TermsConditions"] as? [[String : Any]]{
                    let array = Mapper<EventTersmNCondition>().mapArray(JSONArray:arrObj )
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

/***************************************************************/
//MARK: Event Registration
/***************************************************************/
extension EventService{
    
    static func eventRegistration(eventid:Int,
                                  firstname:String,
                                lastname:String,
                                gender:String,
                                dateofbirth:String,
                                handphone:String,
                                email:String,
                                address1:String?,
                                address2:String?,
                                city:String?,
                                postalcode:String?,
                                profilePic:UIImage?,
                                callback: @escaping (Bool,String) -> Void)  {
        
        guard  let userid = StorageModel.getUserData()?.userid else {return}

        var profilePicData: Data?
        if let image = profilePic{
            profilePicData = UIImageJPEGRepresentation(image, 1.0)!
        }
        
        Common.showHud()
        var dictParam = Dictionary<String,Any>()
        dictParam["userid"] = userid
        dictParam["eventid"] = eventid
        dictParam["firstname"] = firstname
        dictParam["lastname"] = lastname
        dictParam["gender"] = gender
        dictParam["dateofbirth"] = dateofbirth
        dictParam["handphone"] = handphone
        dictParam["email"] = email
        dictParam["address1"] = address1
        dictParam["address2"] = address2
        dictParam["city"] = city
        dictParam["postalcode"] = postalcode
        //dictParam["profilepic"] = profilePicData
        dictParam["status"] = "True"
        
        Service.postRequestWithJsonResponse(endPoint: kServiceUrl+ServiceName.REGISTER_EVENT.rawValue,params: dictParam) { (response) in
            Common.hideHud()
            
            if let obj = response.result.value as? [String:Any]{
                var msg = ""
                if let regNo = obj["registrationnumber"] as? String{
                     msg = "Registered successfully your registration number is \(regNo)"
                }else{
                    if let message = obj["message"] as? String{
                         msg = message
                    }
                }
                callback(true,msg);

               
            } else {
                callback(false,"Error");
            }
            
        }
    }
}

/***************************************************************/
//MARK: My Events
/***************************************************************/
extension EventService{
    
    static func getMyEvents(isOnGoingEvents:Bool,callback: @escaping (Bool,[MyEventModel]?) -> Void)  {
        
        guard  let userid = StorageModel.getUserData()?.userid else {return}

        Common.showHud()
        var dictParam = Dictionary<String,Any>()
        dictParam["userid"] = userid

        var serviceName = ""
        if isOnGoingEvents {
            serviceName = ServiceName.SHOW_ONGOING_EVENTS.rawValue
        }else{
            serviceName = ServiceName.SHOW_COMPLETED_EVENTS.rawValue
        }
        let kServerUrl = kDomain + kEvent + serviceName

        Service.postRequestWithJsonResponse(endPoint: kServerUrl,params: dictParam) { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let arrObj = obj["MyEvents"]  as? [[String:Any]]{
                let array = Mapper<MyEventModel>().mapArray(JSONArray:arrObj)
                callback(true,array);
                }else{
                     callback(false,nil);
                }
            } else {
                callback(false,nil);
            }
            
        }
    }
}

/***************************************************************/
//MARK: My Ticket Booking
/***************************************************************/
extension EventService{
    static func getTicketType(eventid:Int,
                             callback: @escaping (Bool,[TicketType]?) -> Void){
        var dictParam = Dictionary<String,Any>()
        dictParam["eventid"] = eventid
        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.GET_TICKET_TYPE.rawValue
        Service.postRequestWithJsonResponse(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let arrObj = obj["TicketTypes"] as? [[String : Any]]{
                    let array = Mapper<TicketType>().mapArray(JSONArray:arrObj )
                    callback(true,array);
                }else{
                    callback(false,nil);
                }
            }else {
                callback(false,nil);
            }
        }
    }
    
    static func getTicketTypeDetails(eventid:Int,
                                     tickettypeid:Int,
                             callback: @escaping (Bool,TicketTypeDetails?) -> Void){
        var dictParam = Dictionary<String,Any>()
        dictParam["eventid"] = eventid
        dictParam["tickettypeid"] = tickettypeid
        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.SHOW_TICKET_TYPE_DETAIL.rawValue
        Service.postRequestWithJsonResponse(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                let eventDetail = Mapper<TicketTypeDetails>().map(JSON: obj)
                callback(true,eventDetail);
            }else {
                callback(false,nil);
            }
        }
    }
    
    static func getAvailableTicketsCount(eventid:Int,
                                     callback: @escaping (Bool,Int?) -> Void){
        var dictParam = Dictionary<String,Any>()
        dictParam["eventid"] = eventid
        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.AVAILABLE_TICKET_COUNT.rawValue
        Service.postRequestWithJsonResponse(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if  let availableticketscount = obj["availableticketscount"] as? Int{
                     callback(true,availableticketscount)
                }else{
                     callback(false,nil)
                }
            }else {
                callback(false,nil);
            }
        }
    }
    
    static func getAvailableEarlyBirdTicketsCount(eventid:Int,
                                                  tickettypeid:Int,
                                         callback: @escaping (Bool,Int?) -> Void){
        var dictParam = Dictionary<String,Any>()
        dictParam["eventid"] = eventid
        dictParam["tickettypeid"] = tickettypeid
        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.AVAILABEL_EARLY_BIRD_TICKET_COUNT.rawValue
        Service.postRequestWithJsonResponse(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if  let availableticketscount = obj["availableearlybirdticketscount"] as? Int{
                    callback(true,availableticketscount)
                }else{
                    callback(false,nil)
                }
            }else {
                callback(false,nil);
            }
        }
    }
    
}



