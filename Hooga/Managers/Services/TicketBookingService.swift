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
                             callback: @escaping (Bool,BookingDetailResponse?) -> Void){
        
        
        let dictParam = Mapper<SaveBookingDetail>().toJSONArray(bookingDetails)
        
        Common.showHud()
        let kServerUrl = kDomain + kEvent + ServiceName.SAVE_BOOKING_DETAILS.rawValue
        Service.postRequestArrayDictionary(endPoint: kServerUrl, params: dictParam)  { (response) in
            Common.hideHud()
            if let obj = response.result.value as? [String:Any]{
                if let responseObj = obj["BookingDetails"] as? [String : Any]{
                    let array = Mapper<BookingDetailResponse>().map(JSON: responseObj)
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
