//
//  BookingDetailView.swift
//  Hooga
//
//  Created by @mrendra on 03/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

protocol BookingDetailViewDelegate {

    func openGenderPicker(ticketView:BookingDetailView)
    func openDobPicker(ticketView:BookingDetailView)
    func openCityPicker(ticketView:BookingDetailView)
    func openImagePicker(ticketView:BookingDetailView)
    func submit(ticketView:BookingDetailView)
    func save(ticketView:BookingDetailView)
}

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
    
    var delegate : BookingDetailViewDelegate?
    
    @IBAction func buttonUpload_didPressed(_ sender: Any) {
        if delegate != nil {
            
            delegate?.openImagePicker(ticketView: self)
        }
    }
    
    @IBAction func buttonCity_didPressed(_ sender: Any) {
        if delegate != nil {
            
            delegate?.openCityPicker(ticketView: self)
        }
    }
    
    @IBAction func buttonSubmit_didPressed(_ sender: Any) {
        if delegate != nil {
            
            delegate?.submit(ticketView: self)
        }
    }
    
    @IBAction func buttonCancel_didPressed(_ sender: Any) {
        if delegate != nil {
            
            delegate?.save(ticketView: self)
        }
    }
    
    @IBAction func buttonGendder_didPressed(_ sender: Any) {
        
        if delegate != nil {
            
            delegate?.openGenderPicker(ticketView: self)
        }
    }
    
    @IBAction func buttonDob_didPressed(_ sender: Any) {
        if delegate != nil {
            
            delegate?.openDobPicker(ticketView: self)
        }
    }
    
}
