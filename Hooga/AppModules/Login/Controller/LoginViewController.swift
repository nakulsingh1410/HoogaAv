//
//  LoginViewController.swift
//  Hooga
//
//  Created by Nakul Singh on 1/14/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    /*********************************************************************************/
    // MARK: IB_Outlets
    /*********************************************************************************/

    @IBOutlet weak var txtFEmail: HoogaTextField!
    @IBOutlet weak var txtFPassword: HoogaTextField!
    
    /*********************************************************************************/
    // MARK: View controller life cycle methods
    /*********************************************************************************/

    override func viewDidLoad() {
        super.viewDidLoad()
        txtFEmail.text = "marca@gmail.com"
        txtFPassword.text = "1234"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*********************************************************************************/
    // MARK: Methods
    /*********************************************************************************/
    
    private func loginUser()  {
        var message : String?
        if let userName = txtFEmail.text,userName.trimmingCharacters(in: .whitespaces).isEmpty{
            message = MessageError.USER_NAME_BLANK .rawValue
        }else if let password = txtFPassword.text,password.trimmingCharacters(in: .whitespaces).isEmpty {
                       message = MessageError.PASSWORD_EMPTY.rawValue
        }
        if let errorMsg = message {
            Common.showAlert(message: errorMsg)
        }else{
            loginAPI(userName: txtFEmail.text!, password: txtFPassword.text!)
        }
    }
    
    private func userRegistration(){
        NavigationManager.userRegistration(navigationController: self.navigationController)
    }
    
    private func forgotPassword(){
        NavigationManager.forgotPassword(navigationController: self.navigationController)
    }
    
    
    fileprivate func navigateToEvent(){
        NavigationManager.navigateToEvent(navigationController: self.navigationController)
    }
    
    /*********************************************************************************/
    // MARK: IB_Actions
    /*********************************************************************************/
    
    @IBAction func btnLoginTapped(_ sender: Any) {
        loginUser()
//        navigateToEvent()
    }
    @IBAction func btnCancelTapped(_ sender: Any) {
        txtFEmail.text = ""
        txtFPassword.text = ""
    }
    @IBAction func btnRegisterTapped(_ sender: Any) {
        userRegistration()
    }
    @IBAction func btnForgotPasswordTapped(_ sender: Any) {
        forgotPassword()
    }
    
}

/*********************************************************************************/
// MARK: API
/*********************************************************************************/
extension LoginViewController{
    
    func loginAPI(userName:String,password:String)  {
        LoginService.loginUser(username: userName, password: password) {[weak self]  (flag, message) in
            guard let weakSelf = self else {return}
            if flag {
                weakSelf.navigateToEvent()
            }else{
                Common.showAlert(message: message)
            }
        }
    }
     
}
