//
//  Constant.swift
//  ProjectTemplate
//
//  Created by Dotsquares on 16/06/17.
//  Copyright © 2017 Dotsquares. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

public typealias kVC = UIViewController

/**
 * 1. Regular font = kFontRegular
 * 2. Semi Bold = kFontBold
 */
let kIntTransform = TransformOf<String, Any>(fromJSON: { (value: Any?) -> String in
    // transform value from Int? to String?
    return String(describing: value ?? "")
}, toJSON: { (value: String?) -> Int in
    // transform value from String? to Int?
    return Int(value!)!
    
})

let kProjectName = "Hooga"

let kCloseNotification = NSNotification.Name(rawValue: "eventClosed")

let kFontRegular = "ATRotisSemiSerif"
let kFontBold    = "ATRotisSemiSerif-Bold"

let kUserInfo = "userInfo"

/************************ color ************************/

let kBlueColor = UIColor.colorWithHexString(hex: "#0a4a7d")
let kBackgroundColor = UIColor.colorWithHexString(hex: "#0a4a7d")
let kButonBackgroundColor = UIColor.colorWithHexString(hex: "#0080FF")



/*
 
 android:startColor="#089FF2"
 android:endColor="#148CFC"
 */

/************************ xxxxx ************************/


let kCGSizeZero = CGSize(width: 0, height: 0);
let kDeviceID = UIDevice.current.identifierForVendor?.uuidString
var kSize = UIScreen.main.bounds.size
var kBounds = UIScreen.main.bounds
let appDelegate = UIApplication.shared.delegate as! AppDelegate

/************************ Server Url ************************/
let kDomain    = "http://158.140.133.89/HoogaAPI/";
let kSubDomain = "api/users/";
let kEvent     = "api/events/"

let kImgaeView = "http://158.140.133.89/Hooga/HoogaFiles/Assets/"
let kUserImageBaseUrl = "http://158.140.133.89/Hooga/HoogaFiles/users/"
let placeHolderImageUrl = URL(string: "http://158.140.133.89/Hooga/HoogaFiles/Assets/default.png")

let kServiceUrl  = kDomain + kSubDomain

/************************ FontSizes ************************/
struct FontSizes {
    static var delta : CGFloat {
        if UIDevice.isDeviceWithWidth320() {
            return 0;
        }else if UIDevice.isDeviceWithWidth375() {
            return 1.5;
        }else if UIDevice.isDeviceWithWidth414() {
            return 2.5;
        }else{
            return 3.5;
        }
    }
}
/************************ Service List ************************/

public enum ServiceName:String {
    case LOGIN = "validateUser"
    case VERIFY_OTP = "verifyOTP"
    case RIGISTER_USER = "registerUser"
    case SHOW_CATEGORIES = "showCategories"
    case SHOW_ENTRY_TYPES = "showEntryTypes"
    case Fill_TAGS_LIST = "fillTagsList"
    case ON_GOING_EVENTS = "showOngoingEvents"
    case SET_PASSWORD = "setPassword"
    case VERIY_USER = "verifyUser"
    case SHOW_EVENT_DETAIL = "showEventDetails"
    case SHOW_EVENT_ASSETS = "showEventAssets"
    case SHOW_EVENT_Platform = "showEventPlatforms"
    case SHOW_EVENT_FAQs = "showEventFAQs"
    case SHOW_EVENT_TERSM_CONDITION = "showEventTermsConditions"

    case REGISTER_EVENT = "registerEvent"
    case SHOW_ONGOING_EVENTS = "showMyOngoingEvents"
    case SHOW_COMPLETED_EVENTS = "showMyCompletedEvents"
    case DISPLAY_MY_PROFILE = "displayMyProfile"
    case UPDATE_MY_PROFILE = "updateMyProfile"
    case GET_EVENT_TYPE = "getTicketTypes"
    case SHOW_TICKET_TYPE_DETAIL = "showTicketTypeDetails"
    case AVAILABLE_TICKET_COUNT = "getAvailableTicketsCount"
    case AVAILABEL_EARLY_BIRD_TICKET_COUNT = "getAvailableEarlyBirdTicketsCount"
}


/************************ Message ************************/

let kOK = "OK";
let kCancel = "Cancel";

/************************ Error Messages ************************/

public enum MessageError: String{
    
    case USER_FIRST_NAME_BLANK      = "Please enter first name."
    case USER_LAST_NAME_BLANK       = "Please enter last name."
    
    case USER_NAME_BLANK            = "Please enter email / hand phone."
    case EMAIL_BLANK                = "Please enter email address."
    case EMAIL_INVALID              = "Please enter valid email address."
    case USER_GENDER_BLANK          = "Please select gender."
    case USER_DOB_BLANK             = "Please enter date of birth."
    case ADDRESS1_BLANK             = "Please enter address1."
    case ADDRESS2_BLANK             = "Please enter address2."
    case OTP_BLANK                  = "Please enter otp."

    
    case PASSWORD_EMPTY    = "Please enter password."
    case PASSWORD_MATCH    = "Password and Confirm Password should be same."
    case PASSWORD_LENGTH   = "Password should be minimum 6 characters"
    case CNFRMPASSWORD_EMPTY    = "Please enter confirm password."
    case OLD_PASSWORD_EMPTY     = "Please enter old password."
    case NEW_PASSWORD_EMPTY     = "Please enter new password."
    
    case LOCATION_EMPTY         = "Please enter location."
    case COUNTRY_EMPTY          = "Please enter country."
    case STATE_EMPTY            = "Please enter state."
    case CITY_EMPTY             = "Please enter city."
    case POSTCODE_EMPTY         = "Please enter postcode/zip."
    case PHONE_EMPTY            = "Please enter phone number."
    case PHONEVALD_EMPTY        = "Phone number should be minimum 7 characters."
    case MOBILE_EMPTY           = "Please enter mobile number."
    case MOBILEVALD_EMPTY       = "Mobile number should be minimum 10 characters."
    case SPECIALITY_EMPTY       = "Please enter speciality."
    case PROFESSION_EMPTY       = "Please enter profession."
    case SENIORITY_EMPTY        = "Please enter seniority/grade."
    case MEDICAL_CERT_EMPTY     = "Please medical certificate number."
    case REGIS_EMPTY            = "Please registration number."
    case TERMS_ACCEPT           = "Please accept terms and conditions."
    
    case INTERNET_ERROR         = "Please check your internet connection"
    case VERIFICATION_EMPTY     = "Please enter verification code."
    
    
    case PHONE_INVALID          = "Please enter correct mobile number."
    case MEDICAL_EMPTY          = "Please enter medical center name."
    
    case REGISTRATION_MSG       = "Registration successfull. Please activate your account from received email."
}


enum RegisterButtonTitle:String{
    case register = " Register "
    case bookTickets = " Book Tickets "
}

enum ComingFromScreen:String{
    case eventListing = "Event Listing"
    case myEvent = "My Events"
    case registration = "Registration"
    case forgotPassword = "Forgot Password"
}
