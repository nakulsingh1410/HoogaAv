//
//  ThanksVC.swift
//  Hooga
//
//  Created by @mrendra on 06/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class ThanksVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonHome_didPressed(sender : UIButton){
        
        NavigationManager.navigateToEvent(navigationController: self.navigationController)
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
