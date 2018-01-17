//
//  StringExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/22/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import Foundation

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substring(_ from: Int) -> String {
        return self.substring(from: self.characters.index(self.startIndex, offsetBy: from))
    }
    
    var length: Int {
        return self.characters.count
    }
    
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed =    self.trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    //Validate Email
    var isEmail: Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: self)
    }
    
    //validate PhoneNumber
//    var isPhoneNumber: Bool {
//        
//        let charcter  = NSCharacterSet(charactersInString: "+0123456789").invertedSet
//        var filtered:NSString!
//        let inputString:NSArray = self.componentsSeparatedByCharactersInSet(charcter)
//        filtered = inputString.componentsJoinedByString("")
//        return  self == filtered
//        
//    }
}
