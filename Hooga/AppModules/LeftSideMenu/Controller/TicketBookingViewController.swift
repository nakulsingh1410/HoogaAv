//
//  TicketBookingViewController.swift
//  Hooga
//
//  Created by Nakul Singh on 2/2/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class TicketBookingViewController: UIViewController {
    @IBOutlet weak var navHeaderView: CustomNavHeaderView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configoreNavigationHeader()
    }
    
    func configoreNavigationHeader()  {
            navHeaderView.viewController = self
            navHeaderView.navBarTitle = "Ticket Booking"
            navHeaderView.backButtonType = .Back
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
