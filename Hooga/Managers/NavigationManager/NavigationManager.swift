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
        let storyboard = UIStoryboard(name: "Event", bundle:  Bundle(for: LoginViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "EventListViewController") as? EventListViewController{
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    
    class func userRegistration(navigationController:UINavigationController?){
        let storyboard = UIStoryboard(name: "Main", bundle:  Bundle(for: LoginViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController{
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
    
}
