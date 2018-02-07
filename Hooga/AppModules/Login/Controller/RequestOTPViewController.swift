//
//  RequestOTPViewController.swift
//  Hooga
//
//  Created by Nakul Singh on 1/19/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class RequestOTPViewController: UIViewController {

    @IBOutlet weak var lblEmail: HoogaLabel!
    @IBOutlet weak var lblMobile: HoogaLabel!
    @IBOutlet weak var txtFOTP: HoogaTextField!
    
    var screenFlow = ComingFromScreen.registration
    override func viewDidLoad() {
        super.viewDidLoad()
        loadValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*********************************************************************************/
    // MARK: Function
    /*********************************************************************************/
    
    private func loadValues(){
        if let userData = StorageModel.getUserData(){
            if let email = userData.email{
                lblEmail.text = "Email: " + email
            }else{
                lblEmail.text = ""
            }
            if let phone = userData.handphone{
                lblMobile.text = "Mobile: " + phone
            }else{
                lblMobile.text = ""
            }
        }
    }
    
    private func navigateToSetPassword(){
        NavigationManager.navigateToSetPassword(navigationController: self.navigationController)
    }
  

    /*********************************************************************************/
    // MARK: IB_Action
    /*********************************************************************************/
    @IBAction func btnBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSubmitTapped(_ sender: Any) {
        
        if let value = txtFOTP.text,value.trimmingCharacters(in: .whitespaces).isEmpty{
           let message = MessageError.OTP_BLANK .rawValue
            Common.showAlert(message: message)
            return
        }
        view.endEditing(true)
        requestOTP(otp: txtFOTP.text!)
    }
    
    @IBAction func btnRequestOTPTapped(_ sender: Any) {

    }
}


/*********************************************************************************/
// MARK: API
/*********************************************************************************/
extension RequestOTPViewController{
    
    func requestOTP(otp:String)  {
        LoginService.requestOTP(OTP: otp, OTPScreen:screenFlow) {[weak self]  (flag, message) in
            guard let weakSelf = self else {return}
            if flag {
                weakSelf.navigateToSetPassword()
            }else{
                Common.showAlert(message: message)
            }
        }
    }
    
}
