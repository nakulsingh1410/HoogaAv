//
//  PaymentConfirmationVC.swift
//  Hooga
//
//  Created by @mrendra on 03/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class PaymentConfirmationVC: UIViewController {

    @IBOutlet weak var eventType: UILabel!
    
    @IBOutlet weak var referenceNo: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
     override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
    @IBAction func buttonViewTicket_didPressed(_ sender: Any) {
    }
    
}
