//
//  CustomSplashViewController.swift
//  Hooga
//
//  Created by Nakul Singh on 2/14/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class CustomSplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        if appDelegate.arrCountryCode == nil{
            getCountryCodeAPI()
        }else{
            navigationToFirstScreen()
        }
    }
    
    
    func navigationToFirstScreen()  {
        if let _ = StorageModel.getUserData()?.userid {
            LoginService.isUserExist { (flag, message) in
                if flag {
                    NavigationManager.setUpSlideMenu()
                }else{
                    NavigationManager.navigateToLogin(navigationController: self.navigationController)
                }
            }
        }else{
            NavigationManager.navigateToLogin(navigationController: self.navigationController)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getCountryCodeAPI()  {
        LoginService.getCountryCode { [weak self](flag, arraCountryCode) in
            guard let weakSelf = self else {return}
            if let countryCodes = arraCountryCode {
                appDelegate.arrCountryCode = countryCodes
                weakSelf.navigationToFirstScreen()
                
            }else{
                //  Common.showAlert(message: message)
            }
        }
        
    }
    
}
