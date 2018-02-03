//
//  BookingDetailView.swift
//  Hooga
//
//  Created by @mrendra on 03/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class BookingDetailView: UIView {

    @IBOutlet weak var firstName: HoogaTextField!
    
    @IBOutlet weak var lastName: HoogaTextField!
    
    
    @IBOutlet weak var mobile: HoogaTextField!
    
    @IBOutlet weak var email: HoogaTextField!
    
    
    
    
    
    
    
    @IBOutlet weak var dob: HoogaTextField!
    @IBOutlet weak var gender: HoogaTextField!
    
    
    @IBOutlet weak var city: HoogaTextField!
    @IBOutlet weak var address2: HoogaTextField!
    @IBOutlet weak var address1: HoogaTextField!
    
    @IBOutlet weak var postalCode: HoogaTextField!
    @IBAction func buttonUpload_didPressed(_ sender: Any) {
    }
    
    
    @IBAction func buttonCity_didPressed(_ sender: Any) {
    }
    
    @IBAction func buttonPay_didPressed(_ sender: Any) {
        
    }
    
    @IBAction func buttonCancel_didPressed(_ sender: Any) {
    }
    
}
