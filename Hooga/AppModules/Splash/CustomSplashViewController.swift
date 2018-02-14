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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
