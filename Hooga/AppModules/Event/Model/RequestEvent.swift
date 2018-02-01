//
//  RequestEvent.swift
//  Hooga
//
//  Created by @mrendra on 28/01/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import Foundation

class RequestEvent: NSObject {
    
    var catId:Int?
    var entryType:String?
    var tag:String?
    
    
    override init() {
        super.init()
        self.catId = 0
        self.entryType =  ""
        self.tag = ""
    }
}
