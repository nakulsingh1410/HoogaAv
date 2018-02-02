//
//  Extension.swift
//  MedStaff
//
//  Created by ds on 06/10/17.
//  Copyright © 2017 Dotsquares. All rights reserved.
//


import UIKit
import ObjectMapper
import Foundation


//MARK:- NSObject
extension NSObject {
    class func fromJson(jsonInfo: NSDictionary) -> Self {
        let object = self.init()
        
        (object as NSObject).load(jsonInfo: jsonInfo)
        
        return object
    }
    
    func load(jsonInfo: NSDictionary) {
        for (key, value) in jsonInfo {
            let keyName = key as! String
            if (responds(to: Selector(keyName))) {
                setValue(value, forKey: keyName)
            }
        }
    }
    
//    func propertyNames() -> [String] {
//        var names: [String] = []
//        var count: UInt32 = 0
//        let properties = class_copyPropertyList(classForCoder, &count)
//        for i in 0 ..< Int(count) {
//            let property: objc_property_t = properties![i]
//            let name:String = String.init(cString: property_getName(property))
//            names.append(name)
//        }
//        free(properties)
//        return names
//    }
    
//    func asJson() -> NSDictionary {
//        var json:Dictionary<String, AnyObject> = [:]
//
//        for name in propertyNames() {
//            if let value: AnyObject = value(forKey: name) as AnyObject? {
//                json[name] = value
//            }
//        }
//        return json as NSDictionary
//    }
    
}

protocol OptionalString {}
extension String: OptionalString {}


extension Optional where Wrapped: OptionalString {
    
    func isNilOrEmpty() -> Bool {
        return ((self as? String) ?? "").isEmpty
    }
    
}


//MARK: Getting screen size for check conditions
extension UIScreen {
    
    enum SizeType: CGFloat {
        case Unknown = 0.0
        case iPhone4 = 480.0
        case iPhone5 = 568.0
        case iPhone6 = 667.0
        case iPhone6Plus = 736.0
    }
    
    var sizeType: SizeType {
        let height = UIScreen.main.bounds.size.height
        guard let sizeType = SizeType(rawValue: height) else { return .Unknown }
        return sizeType
    }
}
//
//extension UIFont {
//    func cFontSize(_ type:Int)->UIFont{
//        let fontSize = self.pointSize + FontSizes.delta
//        return UIFont(name: Common.getFont(type), size: fontSize)!
//    }
//    func newFontSize(_ type:Int)->UIFont{
//        let fontSize = self.pointSize + FontSizes.delta
//        return UIFont(name: self.fontName, size: fontSize)!
//    }
//}


// MARK:- UIView 

extension UIView {
    
    func fadeIn(duration: TimeInterval = 0.2, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
            self.isHidden = false
            }, completion: completion)  }
    
    func fadeOut(duration: TimeInterval = 0.2, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
            self.isHidden = true
            }, completion: completion)
    }
    
    class func fromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T()), owner: nil, options: nil)![0] as! T
        
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    func appearView() {
        self.alpha = 1
        self.isHidden = false
        
        UIView.animate(withDuration: 3.0, animations: {
            self.alpha = 0
        }, completion: {
            finished in
            self.isHidden = true
        })
    }
    
    func setLayerForView(borderColor bColor : UIColor = .clear, boderWidth width : CGFloat = 0.0, cornerRadius radius : CGFloat = 0.0){
        self.layer.borderColor = bColor.cgColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    @IBInspectable var borderColor: UIColor? {
        get { return layer.borderColor.map(UIColor.init) }
        set { layer.borderColor = newValue?.cgColor }
    }
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue ; layer.masksToBounds = true;}
    }
    
    func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.bounds
        let colorTop = UIColor.init(hex: "#089FF2").cgColor
        let colorBottom = UIColor.init(hex: "#148CFC").cgColor
        gradientLayer.colors = [colorTop, colorBottom]
        
        self.layer.addSublayer(gradientLayer)
    }
    
}

// MARK:- Make StoryBoard Object
extension UIStoryboard
{
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
    class func dashBoardStoryboard() -> UIStoryboard { return UIStoryboard(name: "Dashboard", bundle: Bundle.main) }
    
    func getControllerInstance(storyBoardName : String, identifire : String) -> UIViewController {
        let objStoryBoard = UIStoryboard(name: storyBoardName, bundle: Bundle.main)
        let vc = objStoryBoard.instantiateViewController(withIdentifier: identifire)
        return vc
    }
    
    func getControllerInstanceSplit(storyBoardName : String, identifire : String) -> UISplitViewController {
        let objStoryBoard = UIStoryboard(name: storyBoardName, bundle: Bundle.main)
        let vc = objStoryBoard.instantiateViewController(withIdentifier: identifire)
        return vc as! UISplitViewController
    }
    
    func loadVC<T: UIViewController>(_ type : T.Type) -> T? {
        return self.instantiateViewController(withIdentifier: T.description().className) as? T
    }
    
}

////MARK:- UIApplication
//extension UIApplication {
//    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
//        if let nav = base as? UINavigationController {
//            return topViewController(base: nav.visibleViewController)
//        }
//        if let tab = base as? UITabBarController {
//            if let selected = tab.selectedViewController {
//                return topViewController(base: selected)
//            }
//        }
//        if let presented = base?.presentedViewController {
//            return topViewController(base: presented)
//        }
//        return base
//    }
//}


//MARK:- UITextfield
extension UITextField{
//    func  changePlaceholder(plName : String , color : UIColor){
//        self.attributedPlaceholder = NSAttributedString(string:plName,
//                                                        attributes:[NSAttributedStringKey.foregroundColor: color])
//    }
    func addLeftMargin(leftMargin:CGFloat){
        let paddingView = UIView(frame: CGRect(x:0, y:0, width:leftMargin, height:self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextFieldViewMode.always
    }
    
    func AnimationShakeTextField(textField:UITextField){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        
        
        animation.fromValue = NSValue(cgPoint: CGPoint(x:textField.center.x - 5, y: textField.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 5,y:
            textField.center.y))
        textField.layer.add(animation, forKey: "position")
    }
    
    func isEmptyField() -> Bool {
        guard let text = self.text, !text.isEmpty else {
            if self.attributedPlaceholder != nil {
                self.attributedPlaceholder  =   NSAttributedString(string: self.placeholder!, attributes: nil)
                
            }
            else {
                
            }
            AnimationShakeTextField(textField: self)
            return true
        }
        
        return false
    }
    
    
    
    func isZeroOrLessValue()->Bool{
        
        if (self.text?.characters.count)!>0{
            let isNumber:Bool =  (self.text?.isNumber())!
            
            if isNumber == true{
                
                if  Int(self.text!)! <= 0{
                    // txtResult.text = ""
                    return true
                }
            }
        }
        return false
    }
    
    
    
    func isNumber()->Bool{
        
        let isNumber:Bool =  (self.text?.isNumber())!
        return isNumber
        
    }
}

//MARK:- Array
extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}

//MARK:- UIColor

extension UIColor{
    
    class func colorWithHexString (hex:String) -> UIColor {
        var hexWithoutSymbol:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (hexWithoutSymbol.hasPrefix("#")) {
            hexWithoutSymbol = (hexWithoutSymbol as NSString).substring(from: 1)
        }
        
        let scanner = Scanner(string: hexWithoutSymbol)
        var hexInt:UInt32 = 0x0
        scanner.scanHexInt32(&hexInt)
        
        var r:UInt32!, g:UInt32!, b:UInt32!
        switch (hexWithoutSymbol.characters.count) {
        case 3: // #RGB
            r = ((hexInt >> 4) & 0xf0 | (hexInt >> 8) & 0x0f)
            g = ((hexInt >> 0) & 0xf0 | (hexInt >> 4) & 0x0f)
            b = ((hexInt << 4) & 0xf0 | hexInt & 0x0f)
            break;
        case 6: // #RRGGBB
            r = (hexInt >> 16) & 0xff
            g = (hexInt >> 8) & 0xff
            b = hexInt & 0xff
            break;
        default:
            // TODO:ERROR
            break;
        }
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
}


//MARK:- UIImage
extension UIImage {
    
    func toBase64() -> String{
        let imageData = UIImagePNGRepresentation(self)
        return imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
    }
    
    class func imageFrom(color: UIColor, size:CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func imageMasked(with maskColor: UIColor) -> UIImage {
        let imageRect = CGRect(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height)
        var newImage: UIImage? = nil
        UIGraphicsBeginImageContextWithOptions(imageRect.size, false, self.scale)
        do {
            let context = UIGraphicsGetCurrentContext()!
            context.scaleBy(x: 1.0, y: -1.0)
            context.translateBy(x: 0.0, y: -(imageRect.size.height))
            context.clip(to: imageRect, mask: self.cgImage!)
            context.setFillColor(maskColor.cgColor)
            context.fill(imageRect)
            newImage = UIGraphicsGetImageFromCurrentImageContext()!
        }
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func patternImageRect(targetSize:CGSize?,resultRect:CGRect?) -> UIImage
    {
        
        UIGraphicsBeginImageContext(targetSize!)
        // img.draw(in: CGRect(x:20, y:0, width:20, height:20))
        self.draw(in: resultRect!)
        
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
        // edit.backgroundColor = UIColor(patternImage: newImage)
        
    }
}

extension Data {
    func hexString() -> String {
        return self.reduce("") { string, byte in
            string + String(format: "%02X", byte)
        }
    }
}

//MARK:- Mappable
extension Mappable {
    func toJsonDictionary() -> [String : Any] {
        return Mapper().toJSON(self)
    }
    func toString() -> String {
        return Mapper().toJSONString(self,prettyPrint: true)!
    }
    
}

//MARK:- Date
extension Date {
    
    struct Gregorian {
        static let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
    }
    var startOfWeek: Date
    {
        return Gregorian.calendar.date(from: Gregorian.calendar.components([.yearForWeekOfYear, .weekOfYear ], from: self))!
    }
    
    
    func toString(format:String = "yyyy-MM-dd") -> String{
        let df:DateFormatter = DateFormatter();
        df.dateFormat = format;
        df.amSymbol = "AM"
        df.pmSymbol = "PM"
        return df.string(from: self)
        
    }
    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        return self.compare(dateToCompare as Date) == ComparisonResult.orderedDescending
    }
    
    func isLessThanDate(dateToCompare: NSDate) -> Bool {
        return self.compare(dateToCompare as Date) == ComparisonResult.orderedAscending
    }
    
    func addDays(daysToAdd: Int) -> Date {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: Date = self.addingTimeInterval(secondsInDays)
        
        // Return Result
        return dateWithDaysAdded
    }
    
    func addHours(hoursToAdd: Int) -> Date {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: Date = self.addingTimeInterval(secondsInHours)
        
        // Return Result
        return dateWithHoursAdded
    }
    
}
/*******end*******/


extension String {

    var className:String {
        return self.components(separatedBy: ".").last!
    }
    
    func toDate(format:String = "yyyy-MM-dd") -> Date {
        let df:DateFormatter = DateFormatter();
        df.dateFormat = format;
        df.amSymbol = "AM"
        df.pmSymbol = "PM"
        return df.date(from: self) ?? Date()
    }
    
    func toDateString(format: String = "yyyy-MM-dd",changedFormat: String = "dd MMM , yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {
            return ""
        }
        
        dateFormatter.dateFormat = changedFormat
        let timeStamp = dateFormatter.string(from: date)
        
        return timeStamp
    }
    
    
    func getDateString()->String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatterGet.date(from: self){
          return  dateFormatter.string(from: date)
        }
        return ""
    }
    
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines);
    }
    
//    var attributedStringFromHtml: NSAttributedString? {
//        do {
//            return try NSAttributedString(data: self.data(using: String.Encoding.utf8)!,
//                                                 options: [.documentType: NSAttributedString.DocumentType.html,
//                                                           .characterEncoding: String.Encoding.utf8.rawValue],
//                                                 documentAttributes: nil)
//
//        } catch _ {
//            print("Cannot create attributed String")
//        }
//        return nil
//    }
    
    func emailValidation()-> Bool{
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
    
    var isAlphabates: Bool {
        let val = !isEmpty && range(of: "[^a-zA-Z]", options: .regularExpression) == nil
        return val
    }
    
    
    func isNumber() -> Bool {
        let numberCharacters = NSCharacterSet.decimalDigits.inverted
        return !self.isEmpty && self.rangeOfCharacter(from: numberCharacters) == nil
    }
    
    mutating func ucfirst() -> String {
        if self == nil{
            return self
        }
        if self.characters.count <= 0 {
            return self
        }
        self = self.lowercased()
        self = (self as NSString).replacingCharacters(in: NSRange(location: 0, length: 1), with: self.substring(to: self.index(self.startIndex, offsetBy: 1)).uppercased())
        return self
    }
    
    subscript (i: Int) -> Character {
        return self[self.startIndex]
        
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
}

extension UITableView {
    
    func autoLayoutRegisterNib(nibName:String?){
        if let nibName = nibName {
            self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        }
        self.tableFooterView = UIView()
        self.estimatedRowHeight = 44.0;
        self.rowHeight = UITableViewAutomaticDimension
    }
    
    func  registerTableViewCellWithNib(nibName:String){
        let cellNib = UINib(nibName: nibName, bundle: nil)
        self.register(cellNib, forCellReuseIdentifier: nibName)
        
    }
}

extension UIDevice {
    class func getWidth() -> CGFloat {
        if(UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height){
            return UIScreen.main.bounds.size.height
        }
        return UIScreen.main.bounds.size.width
    }
    class func isDeviceWithWidth320 () -> Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone {
            if UIScreen.main.bounds.size.width == CGFloat(320.0) {
                return true;
            }
        }
        return false;
    }
    
    class func isDeviceWithWidth375 () -> Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone {
            if UIScreen.main.bounds.size.width == CGFloat(375.0) {
                return true;
            }
        }
        return false;
    }
    
    class func isDeviceWithWidth414 () -> Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone {
            if UIScreen.main.bounds.size.width == CGFloat(414.0) {
                return true;
            }
        }
        return false;
    }
    
    class func isDeviceWithHeight480 () -> Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone {
            if UIScreen.main.bounds.size.height == CGFloat(480.0) {
                return true;
            }
        }
        return false;
    }
    
    class func isDeviceWithHeight568 () -> Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone {
            if UIScreen.main.bounds.size.height == CGFloat(568.0) {
                return true;
            }
        }
        return false;
    }
    
    class func isDeviceWithHeight667 () -> Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone {
            if UIScreen.main.bounds.size.height == CGFloat(667.0) {
                return true;
            }
        }
        return false;
    }
    
    class func isDeviceWithHeight736 () -> Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone {
            if UIScreen.main.bounds.size.height == CGFloat(736.0) {
                return true;
            }
        }
        return false;
    }
}



public extension UIWindow {
    public var visibleViewController: UIViewController? {
        return UIWindow.getVisibleViewControllerFrom(vc: self.rootViewController)
    }
    
    public static func getVisibleViewControllerFrom(vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(vc: nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(vc: tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(vc: pvc)
            } else {
                return vc
            }
        }
    }
}

