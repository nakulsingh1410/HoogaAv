//
//  SavePaymentDetail.swift
//  Hooga
//
//  Created by @mrendra on 06/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit
import ObjectMapper


class SavePaymentDetail: NSObject,Mappable {
    
    var userId : Int = 0
    
    var ticketid : Int?
    var otherPayment : String?
    var payrefNumber : String?
    var paidOn : String?
    
    var amountPaid : String?
    var isPaymentApproved : String?
    var createdOn : String?
    var status = "false"

    override init() {
        
        super.init()
        self.ticketid = 0
        self.otherPayment = ""
        self.payrefNumber =  ""
        self.paidOn = ""
        self.amountPaid    = ""
        self.isPaymentApproved = "True"
        self.createdOn = ""
        self.status = "True"
        self.userId = 0
    }
    
    required init?(map: Map) {
        
    }
    public func mapping(map: Map) {
        ticketid                      <- map["ticketid"]
        otherPayment            <- map["otherPayment"]
        payrefNumber            <- map["payrefNumber"]
        paidOn                       <- map["paidOn"]
        amountPaid               <- map["amountPaid"]
        isPaymentApproved            <- map["isPaymentApproved"]
        createdOn            <- map["createdOn"]
        status                  <- map["status"]
    }
    
}

class SavePaymentResponse: NSObject,Mappable {
    
    var ticketID : Int?
    var payRefNumber : String?
   
    /*{ "ticketID": 1, "payRefNumber": "sample string 1" }*/
    required init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        ticketID            <- map["ticketID"]
        payRefNumber            <- map["payRefNumber"]
    }
}
