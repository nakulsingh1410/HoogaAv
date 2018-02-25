//
//  ForgotPasswordViewController.swift
//  Hooga
//
//  Created by Nakul Singh on 1/14/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var txtFEmail: HoogaTextField!
     @IBOutlet weak var countryCodeView: CountryCodeView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        txtFEmail.text = "98580860"
        loadCountryPickerView() 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*********************************************************************************/
    // MARK: Function
    /*********************************************************************************/
    
    func loadCountryPickerView()  {
        var arrCountryCode = [String]()
        if let array = appDelegate.arrCountryCode {
            arrCountryCode = array.map({$0.Code! + " - " +  $0.Country! })
            
        }
        countryCodeView.viewController = self
        countryCodeView.arrCountryCode  = arrCountryCode
        countryCodeView.txtFCountryCode.text = "65"
        countryCodeView.countryCodeViewDelegate = self
        
    }

    private func forgotPassword()  {
        
        guard let userName  = txtFEmail.text,(userName.trimmingCharacters(in: .whitespaces).isEmpty != true) else  {
           Common.showAlert(message: MessageError.USER_NAME_BLANK .rawValue)
            return
        }
         if !userName.isPhoneValid() {
            Common.showAlert(message: MessageError.PHONE_INVALID .rawValue)

         }else{
            setForgotPasswordAPI(password: txtFEmail.text!)
        }
    }
    
    private func navigateToOTP(){
        NavigationManager.navigateToOTP(navigationController: navigationController, screenComingFrom: ComingFromScreen.forgotPassword)
    }
    
    
    /*********************************************************************************/
    // MARK: IB_Action
    /*********************************************************************************/
    @IBAction func btnBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        forgotPassword()
    }
    @IBAction func btnCancelTapped(_ sender: Any) {
        txtFEmail.text = ""
    }
}

extension ForgotPasswordViewController:CountryCodeViewDelegate{
    
    func countryCodeSelected(code:String,index:Int){
        if let code = appDelegate.arrCountryCode?[index].Code{
            countryCodeView.txtFCountryCode.text = code
        }
    }
    
}

/*********************************************************************************/
// MARK: API
/*********************************************************************************/
extension ForgotPasswordViewController{
    
    func setForgotPasswordAPI(password:String)  {
        LoginService.setForgotPassword(username: password) {[weak self]  (flag, message) in
            guard let weakSelf = self else {return}
            if flag {
                weakSelf.navigateToOTP()
            }else{
                Common.showAlert(message: message)
            }
        }
    }
}
