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
                             callback: @escaping (Bool,[BookingDetailResponse]?) -> Void){
        
        
        let dictParam = Mapper<SaveBookingDetail>().toJSONArray(bookingDetails)
        
        
        
        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.SAVE_BOOKING_DETAILS.rawValue
        Service.postRequestArrayDictionary(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let responseObj = obj["BookingDetails"] as? [[String : Any]]{
                    let array = Mapper<BookingDetailResponse>().mapArray(JSONArray: responseObj)
                    callback(true,array);
                }else{
                    callback(false,nil);
                }
            }else {
                callback(false,nil);
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
    
    
    

}
