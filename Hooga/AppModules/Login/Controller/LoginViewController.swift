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
        // Do any additional setup after loading the view.
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
        if let userName = txtFEmail.text,let password = txtFPassword.text {
            loginAPI(userName: userName, password: password)

        }
        
        if let errorMsg = message {
            
        }else{
        }
    }
    
    private func userRegistration(){
        let storyboard = UIStoryboard(name: "Main", bundle:  Bundle(for: LoginViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController{
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    
    private func forgotPassword(){
        let storyboard = UIStoryboard(name: "Main", bundle:  Bundle(for: LoginViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? ForgotPasswordViewController{
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    
    
    
    
    /*********************************************************************************/
    // MARK: IB_Actions
    /*********************************************************************************/
    
    @IBAction func btnLoginTapped(_ sender: Any) {
        loginUser()
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
        LoginService.loginUser(username: userName, password: password) { (flag, message) in
            
        }
    }
    
}
