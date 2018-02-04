//
//  Common.swift
//  Copyright © 2017 Dotsquares. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
class Common: NSObject{

//    static func saveUserInfo(info : UserInfoDto) {
//        let ud = UserDefaults.standard
//        let data = NSKeyedArchiver.archivedData(withRootObject: info)
////        ud.set(NSKeyedArchiver.archivedData(withRootObject: info), forKey: kUserInfo)
//        ud.setValue(data, forKeyPath: kUserInfo);
//        ud.synchronize();
//    }
    
//    static func removeUserInfo() {
//        let ud = UserDefaults.standard
//        ud.removeObject(forKey: kUserInfo)
//    }
    
//    static func getRegisterUserInfo() -> UserInfoDto?{
//        let ud = UserDefaults.standard
//        if let data = ud.object(forKey: kUserInfo)  as? NSData {
//            let info = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! UserInfoDto
//            return info
//        }
//        else{
//            return nil
//        }
//    }
    
    func save(object:Any, key:String){
        UserDefaults.standard.setValue(object, forKeyPath: key);
        UserDefaults.standard.synchronize();
    }
    
    static func getMainStoryBoard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
//    static func getFont(_ type:Int)->String{
//        switch type {
//        case 3:
//            return kFontBold
//        default:
//            return kFontRegular
//        }
//    }
    
    static func navigationControllerWithVC(vc: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: vc)
        let transition = CATransition.init()
        transition.duration = 0.3
        transition.type = kCATransitionFade
        transition.subtype = kCATransitionFromTop;
        navigation.view.layer.add(transition, forKey: kCATransition)
        navigation.isNavigationBarHidden = true
        return navigation
    }
    
    //MARK: - Check Internet
    static func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        if(defaultRouteReachability == nil){
            return false
        }
        var flags : SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    static func isConnectedToWiFi() -> Bool{
        if let reachability = Reachability() {
            do {
                try reachability.startNotifier();
                if reachability.currentReachabilityStatus == .reachableViaWiFi {
                    return true
                }
            }catch {
                
            }
        }
        return false;
        
    }
    
    static func isIPAD()-> Bool{
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            return true;
        }
        return false;
    }
    
    //MARK: - Set Top left bottom right constraints for a view programatically
    
    static func setTLBRForView(view:UIView, superview:UIView, padding:UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)){
        
        view.translatesAutoresizingMaskIntoConstraints = false;
        superview.addConstraints([
            NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1.0, constant: padding.top),
            NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: superview, attribute: .left, multiplier: 1.0, constant: padding.left),
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 1.0, constant: padding.bottom),
            NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: superview, attribute: .right, multiplier: 1.0, constant: padding.right)
            ]);
    }
    
    
    
    // MARK: Show normal Alertview
    static func showAlert(message: String, navController: UINavigationController? = nil, popToRoot:Bool = false) {
        let alertController = UIAlertController(title:kProjectName, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title:"Ok" , style: .default, handler: {
            alert -> Void in
            if navController != nil{
                if(popToRoot){
                    _ = navController?.popToRootViewController(animated: false)
                }else{
                    navController!.popViewController(animated: true)
                }
            }
        })
        alertController.addAction(defaultAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    static func showAlert(_ alertTitle: String?, alertMessage: String?, alertButtons: [String]?, alertPlaceHolder: String?, alertStyle: UIAlertControllerStyle?,inView:UIView?, alertTag: Int?, callback: @escaping (UIAlertController?, String?, Int?) -> Void) {
        
        let alertController = UIAlertController(title: alertTitle ?? "", message: alertMessage, preferredStyle: alertStyle ?? .alert)
        if (inView != nil)  && UIDevice.current.userInterfaceIdiom == .pad{
            alertController.popoverPresentationController?.sourceView = inView
            alertController.popoverPresentationController?.sourceRect = (inView?.bounds)!;
            
        }
        for item in alertButtons! {
            let alertButton = UIAlertAction(title: item, style: .default, handler: { (action) -> Void in
                callback(alertController, item, alertTag);
            })
            alertController.addAction(alertButton)
        }
        
        if alertStyle == .actionSheet {
            let cancelButton = UIAlertAction(title: kCancel, style: .cancel, handler: nil)
            alertController.addAction(cancelButton)
        }
        
        if (alertPlaceHolder != nil) {
            alertController.addTextField { (textField) -> Void in
                textField.placeholder = alertPlaceHolder!
            }
        }
        appDelegate.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    //MARK:- Show HUD
    //    MARK:- HUD
    static func showHud(_ title: String = "Loading...") {
        let hud = HudView.sharedInstance
        hud.title = title
        
        if let topController = UIApplication.topViewController() {
            hud.translatesAutoresizingMaskIntoConstraints = false
            topController.view.addSubview(hud)
            
            Constarints.setConstraint(hud, attribute: .top, relatedBy: .equal, toItem: topController.view, attributeSecond: .top, multiplier: 1.0, constant: 0, vcMain: topController.view);
            
            Constarints.setConstraint(hud, attribute: .leading, relatedBy: .equal, toItem: topController.view, attributeSecond: .leading, multiplier: 1.0, constant: 0, vcMain: topController.view);
            
            Constarints.setConstraint(hud, attribute: .trailing, relatedBy: .equal, toItem: topController.view, attributeSecond: .trailing, multiplier: 1.0, constant: 0, vcMain: topController.view);
            
            Constarints.setConstraint(hud, attribute: .bottom, relatedBy: .equal, toItem: topController.view, attributeSecond: .bottom, multiplier: 1.0, constant:0, vcMain: topController.view);
            
            topController.view.layoutIfNeeded()
            topController.view.bringSubview(toFront: hud)
        }
    }
    
    static func hideHud() {
        HudView.sharedInstance.removeFromSuperview()
    }
    
    static func getString(text:String?)->String{
        if let string = text {
            return string
        }
        return ""
    }
    
    static func backgroundcolorGradient()->CAGradientLayer {
        var gl:CAGradientLayer!
        let colorTop = UIColor.init(hex: "#089FF2").cgColor
        let colorBottom = UIColor.init(hex: "#148CFC").cgColor
        gl = CAGradientLayer()
        gl.colors = [colorTop, colorBottom]
        gl.locations = [0.0, 1.0]
        
        return gl
    }

  static  func createGradientLayer(view:UIView) {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = view.bounds
        let colorTop = UIColor.init(hex: "#089FF2").cgColor
        let colorBottom = UIColor.init(hex: "#148CFC").cgColor
        gradientLayer.colors = [colorTop, colorBottom]
        
        view.layer.addSublayer(gradientLayer)
    }
    
    class func EmptyMessage(message:String, viewController:UIViewController,tableView:UITableView) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: viewController.view.bounds.size.width, height: viewController.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
//        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        tableView.backgroundView = messageLabel;
        tableView.separatorStyle = .none;
    }
    
    
    
    class func getDateString(strDate:String?) -> String {
        if let string = strDate {
            let array = string.components(separatedBy: " ")
            return array.first!
        }
        return ""
    }
    
}



