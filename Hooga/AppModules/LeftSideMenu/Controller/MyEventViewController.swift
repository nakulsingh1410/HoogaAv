//
//  MyEventViewController.swift
//  Hooga
//
//  Created by Nakul Singh on 1/29/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class MyEventViewController: UIViewController {

    @IBOutlet weak var navHeaderView: CustomNavHeaderView!
    override func viewDidLoad() {
        super.viewDidLoad()

        configoreNavigationHeader()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func configoreNavigationHeader()  {
        navHeaderView.viewController = self
        navHeaderView.navBarTitle = "MY EVENTS"
        navHeaderView.backButtonType = .LeftMenu
    }

}
