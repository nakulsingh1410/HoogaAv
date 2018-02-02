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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*********************************************************************************/
    // MARK: Function
    /*********************************************************************************/
    
    private func forgotPassword()  {
        var message : String?
        if let userName = txtFEmail.text,userName.trimmingCharacters(in: .whitespaces).isEmpty{
            message = MessageError.USER_NAME_BLANK .rawValue
        }else if let value = txtFEmail.text,value.isEmail == false{
            message = MessageError.EMAIL_INVALID.rawValue
        }
        
        if let errorMsg = message {
            Common.showAlert(message: errorMsg)
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
