//
//  LongDescriptionViewController.swift
//  Hooga
//
//  Created by Nakul Singh on 2/24/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class LongDescriptionViewController: UIViewController {

    @IBOutlet weak var txtVLongDescription:UITextView!
    @IBOutlet weak var navHeaderView : CustomNavHeaderView!

    var longDescription :String?
    override func viewDidLoad() {
        super.viewDidLoad()

        configoreNavigationHeader()
        
        if let text = longDescription{
            txtVLongDescription.text =  text
        }
        
    }

    func configoreNavigationHeader()  {
        navHeaderView.viewController = self
        navHeaderView.navBarTitle = "Description"
        navHeaderView.backButtonType = .Back
        navHeaderView.isNavBarTransparent = true
        navHeaderView.setLeftMenu()
        
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
