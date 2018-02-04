//
//  LuckyDrawVC.swift
//  Hooga
//
//  Created by @mrendra on 04/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class LuckyDrawVC: UIViewController {

    @IBOutlet weak var ticketDetail: UITextView!
    
    @IBOutlet weak var luckyCode: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var firstName: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttonParticipat_didPressed(_ sender: Any) {
    }
    
    @IBAction func buttonBack_didPressed(_ sender: Any) {
    }
    

}
