//
//  TicketBookingService.swift
//  Hooga
//
//  Created by Nakul Singh on 2/4/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import Foundation
import ObjectMapper

/***************************************************************/
//MARK: Ticket Booking Details
/***************************************************************/
class TicketBookingService{
    static func saveTicketDetails(bookingDetails:[SaveBookingDetail],
                                  callback: @escaping (Bool,[BookingDetailResponse]?,[ErrorBookingDetails]?,String?) -> Void){
        
        let dictParam = Mapper<SaveBookingDetail>().toJSONArray(bookingDetails)
        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.SAVE_BOOKING_DETAILS.rawValue
        Service.postRequestArrayDictionary(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let responseObj = obj["BookingDetails"] as? [[String : Any]]{
                    let array = Mapper<BookingDetailResponse>().mapArray(JSONArray: responseObj)
                    callback(true,array,nil,nil);
                }else if let responseObj = obj["ErrorBookingDetails"] as? [[String : Any]]{
                    let errorArray = Mapper<ErrorBookingDetails>().mapArray(JSONArray: responseObj)
                    callback(true,nil,errorArray,nil);
                }else{
                    callback(false,nil,nil,Common.getString(text: obj["message"] as? String));
                }
            }else {
                callback(false,nil,nil,"Error occured");
            }
        }
    }
    
    
    static func paymentDetails(bookingDetails:[SavePaymentDetail],
                               callback: @escaping (Bool,[SavePaymentResponse]?) -> Void){
        
        
        let dictParam = Mapper<SavePaymentDetail>().toJSONArray(bookingDetails)
        
        
        
        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.SAVE_OTHER_PAYMENT_DETAIL.rawValue
        Service.postRequestArrayDictionary(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let responseObj = obj["PaymentDetails"] as? [[String : Any]]{
                    let array = Mapper<SavePaymentResponse>().mapArray(JSONArray: responseObj)
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
//MARK: Lucky Draw
/***************************************************************/
extension  TicketBookingService{
    static func showMyEventLuckyDrawStatus(eventid:Int,
                                           callback: @escaping (Bool,String?) -> Void){
        
        
        var dictParam = Dictionary<String,Any>()
        dictParam["eventid"] = eventid        
        
        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.SHOW_MY_EVENT_LUCKY_DRAW_STATUS.rawValue
        Service.postRequestWithJsonResponse(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let responseObj = obj["Isluckydraw"] as? String{
                    callback(true,responseObj);
                }else{
                    callback(false,nil);
                }
            }else {
                callback(false,nil);
            }
        }
    }
    static func showMyEventLuckyDrawPrizes(eventid:Int,
                                           callback: @escaping (Bool,[ShowMyEventLuckyDrawPrizes]?) -> Void){
        
        
        var dictParam = Dictionary<String,Any>()
        dictParam["eventid"] = eventid
        
        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.SHOW_EVENT_LUCKY_DRAW_PRIZES.rawValue
        Service.postRequestWithJsonResponse(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let responseObj = obj["LuckyDrawPrizes"] as? [[String:Any]]{
                    let array = Mapper<ShowMyEventLuckyDrawPrizes>().mapArray(JSONArray: responseObj)
                    callback(true,array);
                }else{
                    callback(false,nil);
                }
                
            }else {
                callback(false,nil);
            }
        }
    }
    
    static func showMyEventLuckyDraw(eventid:Int,
                                     callback: @escaping (Bool,ShowMyEventLuckyDraw?) -> Void){
        
        
        var dictParam = Dictionary<String,Any>()
        dictParam["eventid"] = eventid
        
        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.SHOW_MY_EVENT_LUCKY_DRAW.rawValue
        Service.postRequestWithJsonResponse(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                let model = Mapper<ShowMyEventLuckyDraw>().map(JSON: obj)
                callback(true,model);
            }else {
                callback(false,nil);
            }
        }
    }
    static func showMyTicketDetails(eventid:Int,
                                    registrationid:Int,
                                    callback: @escaping (Bool,[ShowMyTicketDetails]?) -> Void){
        
        
        var dictParam = Dictionary<String,Any>()
        dictParam["eventid"] = eventid
        dictParam["registrationid"] = registrationid
        
        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.SHOW_MY_TICKET_DETAILS.rawValue
        Service.postRequestWithJsonResponse(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let responseObj = obj["ShowTickets"] as? [[String:Any]]{
                    let array = Mapper<ShowMyTicketDetails>().mapArray(JSONArray: responseObj)
                    callback(true,array);
                }else{
                    callback(false,nil);
                }
            }else {
                callback(false,nil);
            }
        }
    }
    
    static func generateLuckyDrawNumber(eventid:Int,
                                        registrationid:Int,
                                        ticketid:Int,
                                        callback: @escaping (Bool,GenerateLuckyDrawNumber?) -> Void){
        
        
        var dictParam = Dictionary<String,Any>()
        dictParam["eventid"] = eventid
        dictParam["registrationid"] = registrationid
        dictParam["ticketid"] = ticketid
        
        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.GENEARET_LUCKY_DRAW_NO.rawValue
        Service.postRequestWithJsonResponse(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                let model = Mapper<GenerateLuckyDrawNumber>().map(JSON: obj)
                callback(true,model);
                
            }else {
                callback(false,nil);
            }
        }
    }
    
    static func showMyEventLuckyDrawResult(eventid:Int,
                                           registrationid:Int,
                                           callback: @escaping (Bool,[ShowMyEventLuckyDrawResult]?) -> Void){
        
        
        var dictParam = Dictionary<String,Any>()
        dictParam["eventid"] = eventid
        dictParam["registrationid"] = registrationid
        
        
        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.SHOW_MY_EVENT_LUCKY_DRAW_RESULT.rawValue
        Service.postRequestWithJsonResponse(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let responseObj = obj["LuckyDrawDetails"] as? [[String:Any]]{
                    let array = Mapper<ShowMyEventLuckyDrawResult>().mapArray(JSONArray: responseObj)
                    callback(true,array);
                }else{
                    callback(false,nil);
                }
                
            }else {
                callback(false,nil);
            }
        }
        
        
    }
    
    static func showTicketQRCodes(registrationid:Int,
                                  eventID:Int,
                                  callback: @escaping (Bool,[QRCodeTickets]?) -> Void){
        guard  let userid = StorageModel.getUserData()?.userid else {return}

        var dictParam = Dictionary<String,Any>()
        dictParam["userid"] = userid
        dictParam["registrationid"] = registrationid
        dictParam["eventid"] = eventID
       
        
        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.SHOW_TICKET_QR_CODES.rawValue
        Service.postRequestWithJsonResponse(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let responseObj = obj["TicketQRCodes"] as? [[String:Any]]{
                    let array = Mapper<QRCodeTickets>().mapArray(JSONArray: responseObj)
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

// for free event
extension TicketBookingService{
    static func showRegistrationDetails(eventid:Int,
                                        registrationid:Int,
                                           callback: @escaping (Bool,[ShowMyTicketDetails]?) -> Void){
        
        
        var dictParam = Dictionary<String,Any>()
        dictParam["eventid"] = eventid
        dictParam["registrationid"] = registrationid

        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.SHOW_REGISTRATION_DETAIL.rawValue
        Service.postRequestWithJsonResponse(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let responseObj = obj["ShowTickets"] as? [[String:Any]]{
                    let array = Mapper<ShowMyTicketDetails>().mapArray(JSONArray: responseObj)
                    callback(true,array);
                }else{
                    callback(false,nil);
                }
            }else {
                callback(false,nil);
            }
        }
    }

    static func generateFreeLuckyDrawNumber(eventid:Int,
                                           registrationid:Int,
                                           callback: @escaping (Bool,GenerateLuckyDrawNumber?) -> Void){
        
        
        var dictParam = Dictionary<String,Any>()
        dictParam["eventid"] = eventid
        dictParam["registrationid"] = registrationid

        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.GENERATE_FREE_LUCKY_DRAW_NO.rawValue
        Service.postRequestWithJsonResponse(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                let model = Mapper<GenerateLuckyDrawNumber>().map(JSON: obj)
                callback(true,model);
                
            }else {
                callback(false,nil);
            }
        }
    }
    
    static func showMyFreeEventLuckyDrawResult(eventid:Int,
                                     registrationid:Int,
                                     callback: @escaping (Bool,[ShowMyEventLuckyDrawResult]?) -> Void){
        
        
        var dictParam = Dictionary<String,Any>()
        dictParam["eventid"] = eventid
        dictParam["registrationid"] = registrationid

        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.SHOW_MY_FREE_LUCKY_DRAW_RESULT.rawValue
        Service.postRequestWithJsonResponse(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let responseObj = obj["LuckyDrawDetails"] as? [[String:Any]]{
                    let array = Mapper<ShowMyEventLuckyDrawResult>().mapArray(JSONArray: responseObj)
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
