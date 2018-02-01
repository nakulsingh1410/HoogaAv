//
//  NavigationManager.swift
//  Hooga
//
//  Created by Nakul Singh on 1/28/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class NavigationManager {
    
    class func navigateToEvent(navigationController:UINavigationController?){
        NavigationManager.setUpSlideMenu()
//        let storyboard = UIStoryboard(name: "Event", bundle:  Bundle(for: LoginViewController.self) )
//        if let vcObj = storyboard.instantiateViewController(withIdentifier: "EventListViewController") as? EventListViewController{
//            navigationController?.pushViewController(vcObj, animated: true)
//        }
    }
    
    class func userRegistration(navigationController:UINavigationController?,screenShown:RequestForScreen){
        let storyboard = UIStoryboard(name: "Main", bundle:  Bundle(for: LoginViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController{
            vcObj.requestingScreen = screenShown
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    
    class func forgotPassword(navigationController:UINavigationController?){
        let storyboard = UIStoryboard(name: "Main", bundle:  Bundle(for: LoginViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? ForgotPasswordViewController{
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    
    class func navigateToSetPassword(navigationController:UINavigationController?){
        let storyboard = UIStoryboard(name: "Main", bundle:  Bundle(for: RequestOTPViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "SetPasswordViewController") as? SetPasswordViewController{
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    
    class func eventDetail(navigationController:UINavigationController? , evnt : Events){
        let storyboard = UIStoryboard(name: "EventDetail", bundle:  Bundle(for: EventDetailVC.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "EventDetail") as? EventDetailVC{
            vcObj.event = evnt
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    class func eventRegistration(navigationController:UINavigationController? , evntDetail : EventDetail){
        let storyboard = UIStoryboard(name: "EventRegistration", bundle:  Bundle(for: EventRegisterationViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "EventRegisterationViewController") as? EventRegisterationViewController{
            vcObj.eventDetail = evntDetail
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    
    class func logout(){
        let storyboard = UIStoryboard(name: "Main", bundle:  Bundle(for: LoginViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController{
            let nvc: UINavigationController = UINavigationController(rootViewController: vcObj)
            UINavigationBar.appearance().tintColor = UIColor.white
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
            UINavigationBar.appearance().barTintColor = kBlueColor
            nvc.navigationBar.isHidden = true
            vcObj.modalTransitionStyle = .crossDissolve
            vcObj.modalPresentationStyle = .custom
            appDelegate.window?.rootViewController = nvc
            appDelegate.window?.makeKeyAndVisible()
        }
    }
    
    
    
     class func setUpSlideMenu()  {
        let storyboard = UIStoryboard(name: "Event", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "EventListViewController") as! EventListViewController
        
        let sideMenuStorybard =  UIStoryboard(name: "SlideMenu", bundle: nil)
        let leftViewController = sideMenuStorybard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
        let rightViewController = sideMenuStorybard.instantiateViewController(withIdentifier: "RightViewController") as! RightViewController
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        UINavigationBar.appearance().barTintColor = kBlueColor
        nvc.navigationBar.isHidden = true
        
        
        leftViewController.mainViewController = nvc
        
        let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)
//        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        //        slideMenuController.delegate = mainViewController
        appDelegate.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        appDelegate.window?.rootViewController = slideMenuController
        appDelegate.window?.makeKeyAndVisible()
    }
    
}
