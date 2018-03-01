//
//  SetPasswordViewController.swift
//  Hooga
//
//  Created by Nakul Singh on 1/28/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class SetPasswordViewController: UIViewController {
    /*********************************************************************************/
    // MARK: IB_Outlets
    /*********************************************************************************/
    
    @IBOutlet weak var txtFPassword: HoogaTextField!
    @IBOutlet weak var txtFConfirmPassword: HoogaTextField!
    @IBOutlet weak var navHeaderView: CustomNavHeaderView!

    var screenFlow = ComingFromScreen.registration

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configoreNavigationHeader()
    }
    
    func configoreNavigationHeader()  {
        navHeaderView.viewController = self
        if screenFlow == ComingFromScreen.registration{
            navHeaderView.navBarTitle = "Set Password"
        }else if screenFlow == ComingFromScreen.forgotPassword{
            navHeaderView.navBarTitle = "Reset Password"
        }
        navHeaderView.backButtonType = .Back
        navHeaderView.leftButton.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    fileprivate func navigateToEvent(){
        NavigationManager.navigateToEvent(navigationController: self.navigationController)
    }
    
    /*********************************************************************************/
    // MARK: IB_Action
    /*********************************************************************************/
//    @IBAction func btnBackTapped(_ sender: Any) {
//        navigationController?.popViewController(animated: true)
//    }
    @IBAction func btnSubmitTapped(_ sender: Any) {
        var message : String?
        if let value = txtFPassword.text,value.trimmingCharacters(in: .whitespaces).isEmpty{
            message = MessageError.PASSWORD_EMPTY .rawValue
        }else if let value = txtFConfirmPassword.text,value.trimmingCharacters(in: .whitespaces).isEmpty {
            message = MessageError.CNFRMPASSWORD_EMPTY.rawValue
        }else if  txtFPassword.text != txtFConfirmPassword.text{
            message = MessageError.PASSWORD_MATCH.rawValue
        }
        
        if let errorMsg = message {
            Common.showAlert(message: errorMsg)
        }else{
            setPasswordAPI(password:txtFPassword.text!)
        }
    }
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

/*********************************************************************************/
// MARK: API
/*********************************************************************************/
extension SetPasswordViewController{
    
    func setPasswordAPI(password:String)  {
        LoginService.setPassword(password: password) {[weak self]  (flag, message) in
            guard let weakSelf = self else {return}
            if flag {
                weakSelf.getMyProfile()
               
            }else{
                Common.showAlert(message: message)
            }
        }
    }
    
    func getMyProfile(){
        LoginService.getMyProfile(callback: {[weak self] (flag, message) in
            guard let weakSelf = self else {return}
            if flag {
                 weakSelf.navigateToEvent()
            }else{
                Common.showAlert(message: message)

            }
        })
    }
    
}
