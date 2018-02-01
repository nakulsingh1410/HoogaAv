//
//  LoginResponseDto.swift
//  Hooga
//
//  Created by Nakul Singh on 1/14/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import Foundation


import UIKit
import ObjectMapper

class LoginResponseDto: NSObject,Mappable,NSCoding {
    
        var userid : Int?
        var firstname : String?
        var lastname : String?
        var gender : String?
        var usertype : String?
        var dateofbirth : String?
        var handphone : String?
        var email : String?
        var address1 : String?
        var address2 : String?
        var city : String?
        var postalcode : String?
        var profilepic : String?
        var isfirsttimeuser : String?
        var status : String?
        var Message : String?
    
    override init() {
        
    }
    required init?(map: Map) {
        userid            <- map["userid"]
        firstname         <- map["firstname"]
        lastname          <- map["lastname"]
        gender            <- map["gender"]
        usertype          <- map["usertype"]
        dateofbirth       <- map["dateofbirth"]
        handphone         <- map["handphone"]
        
        email           <- map["email"]
        address1        <- map["address1"]
        address2        <- map["address2"]
        city            <- map["city"]
        
        postalcode          <- map["postalcode"]
        profilepic          <- map["profilepic"]
        isfirsttimeuser     <- map["isfirsttimeuser"]
        status              <- map["status"]
        Message             <- map["Message"]
    }
    
    public func mapping(map: Map) {
        userid            <- map["userid"]
        firstname         <- map["firstname"]
        lastname          <- map["lastname"]
        gender            <- map["gender"]
        usertype          <- map["usertype"]
        dateofbirth       <- map["dateofbirth"]
        handphone         <- map["handphone"]
        
        email           <- map["email"]
        address1        <- map["address1"]
        address2        <- map["address2"]
        city            <- map["city"]

        postalcode          <- map["postalcode"]
        profilepic          <- map["profilepic"]
        isfirsttimeuser     <- map["isfirsttimeuser"]
        status              <- map["status"]
        Message             <- map["Message"]
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        userid =  aDecoder.decodeObject(forKey: "userid") as? Int
        firstname =  aDecoder.decodeObject(forKey: "firstname") as? String
        lastname =  aDecoder.decodeObject(forKey: "lastname") as? String
        gender =  aDecoder.decodeObject(forKey: "gender") as? String
        usertype =  aDecoder.decodeObject(forKey: "usertype") as? String
        dateofbirth =  aDecoder.decodeObject(forKey: "dateofbirth") as? String
        handphone =  aDecoder.decodeObject(forKey: "handphone") as? String
        email =  aDecoder.decodeObject(forKey: "email") as? String
        address1 =  aDecoder.decodeObject(forKey: "address1") as? String
        address2 =  aDecoder.decodeObject(forKey: "address2") as? String
        city =  aDecoder.decodeObject(forKey: "city") as? String
        postalcode =  aDecoder.decodeObject(forKey: "postalcode") as? String
        profilepic =  aDecoder.decodeObject(forKey: "profilepic") as? String
        isfirsttimeuser =  aDecoder.decodeObject(forKey: "isfirsttimeuser") as? String
        status =  aDecoder.decodeObject(forKey: "status") as? String
        Message =  aDecoder.decodeObject(forKey: "Message") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(userid, forKey: "userid")
        aCoder.encode(firstname, forKey: "firstname")
        aCoder.encode(lastname, forKey: "lastname")
        aCoder.encode(gender, forKey: "gender")
        aCoder.encode(usertype, forKey: "usertype")
        aCoder.encode(dateofbirth, forKey: "dateofbirth")
        aCoder.encode(handphone, forKey: "handphone")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(address1, forKey: "address1")
        aCoder.encode(address2, forKey: "address2")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(postalcode, forKey: "postalcode")
        aCoder.encode(isfirsttimeuser, forKey: "isfirsttimeuser")
        aCoder.encode(status, forKey: "status")
        aCoder.encode(Message, forKey: "Message")
        
    }
}
