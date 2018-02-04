//
//  QcodeTicketVC.swift
//  Hooga
//
//  Created by @mrendra on 04/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class QcodeTicketVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var qrCodeImage: UIImageView!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var eventType: UILabel!
    
 

}
