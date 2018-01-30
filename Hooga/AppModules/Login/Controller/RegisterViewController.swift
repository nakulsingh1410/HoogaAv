//
//  RegisterViewController.swift
//  Hooga
//
//  Created by Nakul Singh on 1/14/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

enum Gender:String{
    case male = "Male"
     case female = "Female"
}

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var txtFFirstName: HoogaTextField!
    @IBOutlet weak var txtFLastName: HoogaTextField!
    @IBOutlet weak var txtFGender: HoogaTextField!
    @IBOutlet weak var txtFPhoneNumber: HoogaTextField!
    
    @IBOutlet weak var txtFDOB: HoogaTextField!
    @IBOutlet weak var txtFEmail: HoogaTextField!
    @IBOutlet weak var txtFAddress1: HoogaTextField!
    @IBOutlet weak var txtFAddress2: HoogaTextField!
    @IBOutlet weak var txtFCity: HoogaTextField!
    @IBOutlet weak var txtFPostalCode: HoogaTextField!
    @IBOutlet weak var imgViewProfilePic: UIImageView!
    @IBOutlet weak var btnUpload: HoogaButton!
    
    var arrGender = [Gender.male.rawValue,Gender.female.rawValue]
    var arrCity = ["Singapore"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        txtFCity.text = "Singapore"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*********************************************************************************/
    // MARK: Methods
    /*********************************************************************************/
    
    private func openGenderPicker(){
        if let picker = CustomPickerView.loadPickerView(){
            picker.frame = view.frame
            picker.pickerType = .gendePicker
            picker.pickerDataSource = arrGender
            picker.customPickerViewDelegate = self
            view.addSubview(picker)
        }
    }
    private func openCityPicker(){
        if let picker = CustomPickerView.loadPickerView(){
            picker.frame = view.frame
            picker.pickerType = .cityPicker
            picker.pickerDataSource = arrCity
            picker.customPickerViewDelegate = self
            view.addSubview(picker)
        }
    }
    private func openDatePicker(){
        if let picker = CustomDatePicker.loadDatePickerView(){
            picker.frame = view.frame
            picker.customDatePickerDelegate = self
            
            view.addSubview(picker)
        }
    }
    
    private func validate()->(message:String?,isEmpty:Bool){
        
        var message : String?
        if let value = txtFFirstName.text,value.trimmingCharacters(in: .whitespaces).isEmpty{
            message = MessageError.USER_FIRST_NAME_BLANK .rawValue
        }else if let value = txtFLastName.text,value.trimmingCharacters(in: .whitespaces).isEmpty {
            message = MessageError.USER_LAST_NAME_BLANK .rawValue
        }else if let value = txtFGender.text,value.trimmingCharacters(in: .whitespaces).isEmpty {
            message = MessageError.USER_GENDER_BLANK .rawValue
        }else if let value = txtFPhoneNumber.text,value.trimmingCharacters(in: .whitespaces).isEmpty {
            message = MessageError.PHONE_EMPTY .rawValue
        }else if let value = txtFDOB.text,value.trimmingCharacters(in: .whitespaces).isEmpty {
            message = MessageError.USER_DOB_BLANK .rawValue
        }else if let value = txtFEmail.text,value.trimmingCharacters(in: .whitespaces).isEmpty {
            message = MessageError.EMAIL_BLANK.rawValue
        }else if let value = txtFEmail.text,value.isEmail == false{
            message = MessageError.EMAIL_INVALID.rawValue
        }
        
//        else if let value = txtFAddress1.text,value.trimmingCharacters(in: .whitespaces).isEmpty {
//            message = MessageError.ADDRESS1_BLANK .rawValue
//        }else if let value = txtFAddress2.text,value.trimmingCharacters(in: .whitespaces).isEmpty {
//            message = MessageError.ADDRESS2_BLANK .rawValue
//        }else if let value = txtFCity.text,value.trimmingCharacters(in: .whitespaces).isEmpty {
//            message = MessageError.CITY_EMPTY.rawValue
//        }else if let value = txtFPostalCode.text,value.trimmingCharacters(in: .whitespaces).isEmpty {
//            message = MessageError.POSTCODE_EMPTY.rawValue
//        }
        return (message == nil) ? (message,false):(message,true)
    }
    
    private func registerUser()  {
        let touple =   validate()
        if touple.isEmpty == true , let errorMsg = touple.message {
            Common.showAlert(message: errorMsg)
        }else{
            registerAPI()
        }
    }
    
    private func pickProfileImage(){
        let imageController = OpenImagePickerViewController()
        imageController.configure {[weak self]  (flag, image) in
               guard let weakSelf = self else {return}
            if flag {
                weakSelf.imgViewProfilePic.image = image
                weakSelf.btnUpload.isHidden = true
            }
            else{
                
            }
        }
        let vcObj = appDelegate.window?.visibleViewController
        vcObj?.present(imageController, animated: true, completion: nil);
    }
    
    private func navigateToOTP(){
        let storyboard = UIStoryboard(name: "Main", bundle:  Bundle(for: LoginViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "RequestOTPViewController") as? RequestOTPViewController{
            vcObj.screenFlow = "RegisterationFlow"
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    
    /*********************************************************************************/
    // MARK: IB_Action
    /*********************************************************************************/
    @IBAction func btnBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }    
    
    @IBAction func btnGenderTapped(_ sender: Any) {
        view.endEditing(true)
        openGenderPicker()
    }
    
    @IBAction func btnDOBTapped(_ sender: Any) {
         view.endEditing(true)
        openDatePicker()
    }
    
    @IBAction func btnUploadTapped(_ sender: Any) {
         view.endEditing(true)
        pickProfileImage()
    }
    
    @IBAction func btnCityTapped(_ sender: Any) {
         view.endEditing(true)
        openCityPicker()
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
//        registerUser()
         view.endEditing(true)
        navigateToOTP()
        
    }
    @IBAction func btnCancelTapped(_ sender: Any) {
         view.endEditing(true)
        txtFFirstName.text = ""
        txtFLastName.text = ""
        txtFGender.text = ""
        txtFPhoneNumber.text = ""
        txtFDOB.text = ""
        txtFEmail.text = ""
        txtFAddress1.text = ""
        txtFAddress2.text = ""
        txtFCity.text = ""
        txtFPostalCode.text = ""
    }
}
/*********************************************************************************/
// MARK: CustomPickerView Deleagte
/*********************************************************************************/
extension RegisterViewController:CustomPickerViewDelegate{
    func dismissPickerView() {
        
    }
    func didSelectPickerValueAt(title: String, index: Int, pickerType: PickerType?) {
        if let type = pickerType , type == .gendePicker {
            txtFGender.text = (title == Gender.male.rawValue) ? "M" : "F"
        }
        if let type = pickerType , type == .cityPicker {
            txtFCity.text = title
        }
    }
}

/*********************************************************************************/
// MARK: CustomDatePicker Deleagte
/*********************************************************************************/
extension RegisterViewController:CustomDatePickerDelegate{
  
    func didSelectDate(dob: String) {
        txtFDOB.text = dob
    }
}

/*********************************************************************************/
// MARK: API
/*********************************************************************************/
extension RegisterViewController{
    
    func registerAPI()  {
        LoginService.appRegisterUser(firstname: txtFFirstName.text!,
                                     lastname: txtFLastName.text!,
                                     gender: txtFGender.text!,
                                     dateofbirth: txtFDOB.text!,
                                     handphone: txtFPhoneNumber.text!,
                                     email: txtFEmail.text!,
                                     address1: txtFAddress1.text,
                                     address2: txtFAddress2.text,
                                     city: txtFCity.text,
                                     postalcode: txtFPostalCode.text,
                                     profilePic:imgViewProfilePic.image) {[weak self]  (flag, message) in
                                        
                                        guard let weakSelf = self else {return}
                                        if flag {
                                            weakSelf.navigateToOTP()
                                        }else{
                                            Common.showAlert(message: message)
                                        }
        }
    }
    
}
