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
    @IBOutlet weak var navHeaderView: CustomNavHeaderView!

    
    var screenFlow = ComingFromScreen.registration
    override func viewDidLoad() {
        super.viewDidLoad()
        configoreNavigationHeader()
        loadValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*********************************************************************************/
    // MARK: Function
    /*********************************************************************************/
    func configoreNavigationHeader()  {
        navHeaderView.viewController = self
        navHeaderView.navBarTitle = "Submit OTP"
        navHeaderView.backButtonType = .Back
        navHeaderView.leftButton.isHidden = true
    }
    
    private func loadValues(){
        lblEmail.text = ""
        lblMobile.text = ""
        if let userData = StorageModel.getUserData(){
//            if let email = userData.email,email.length > 0{
//                lblEmail.text = "Email" + "\n" + email
//            }else{
//                lblEmail.text = ""
//            }
            lblEmail.text = ""
            if let phone = userData.handphone,phone.length>0{
                 var phoneNo = phone
                if let countrycode = userData.countrycode,countrycode.length > 0{
                    phoneNo = countrycode + " " + phoneNo
                }
                lblMobile.text = "Hand Phone" + "\n" + phoneNo
            }else{
                lblMobile.text = ""
            }
        }
        
    }
 
    
    private func navigateToSetPassword(){
        NavigationManager.navigateToSetPassword(navigationController: self.navigationController, screenFlow: screenFlow)
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
        if let userData = StorageModel.getUserData(){
            if let phoneNo = userData.handphone,phoneNo.length>0{
                generateOTP(mobile: phoneNo)
            }
        }
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
    
    
    func generateOTP(mobile:String) {
        LoginService.generateOTP(handphone: mobile, OTPScreen: screenFlow) {  (flag, message) in
            Common.showAlert(message: "OTP has been sent to your registered Hand Phone")
        }
    }
    
}
