//
//  MyProfileViewController.swift
//  Hooga
//
//  Created by Nakul Singh on 1/14/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit


class MyProfileViewController: UIViewController {
    
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
    
    @IBOutlet weak var navHeaderView : CustomNavHeaderView!

    var requestingScreen:RequestForScreen = .login
    
    var arrGender = [Gender.male.rawValue,Gender.female.rawValue,Gender.other.rawValue]
    var arrCity = ["Singapore"]
    override func viewDidLoad() {
        super.viewDidLoad()
        configoreNavigationHeader()
        txtFCity.text = "Singapore"
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
         prefilledUsedData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*********************************************************************************/
    // MARK: Methods
    /*********************************************************************************/
   private func configoreNavigationHeader()  {
        navHeaderView.viewController = self
        navHeaderView.navBarTitle = "My Profile"
        navHeaderView.backButtonType = .LeftMenu
    
    }
    private func prefilledUsedData(){
        if let userData = StorageModel.getUserData(){
            txtFFirstName.text = userData.firstname
            txtFLastName.text = userData.lastname
            txtFGender.text = userData.gender
            txtFPhoneNumber.text = userData.handphone
            txtFDOB.text = userData.dateofbirth
            txtFEmail.text = userData.email
            txtFAddress1.text = userData.address1
            txtFAddress2.text = userData.address2
            txtFCity.text = userData.city
            txtFPostalCode.text = userData.postalcode
            
            if let profilepic = userData.profilepic {
                let url = kUserImageBaseUrl + profilepic
                imgViewProfilePic.kf.setImage(with: URL(string:url), placeholder: nil, options: nil, progressBlock: nil){ (image, error, cacheType, url) in
                    if image == nil {
                        self.btnUpload.isHidden = false
                    }
                }
                
            }
        }
        
    }

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
        }else if let value = txtFDOB.text,value == "__/ __/ __" {
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
    
    private func updateUser()  {
        let touple =   validate()
        if touple.isEmpty == true , let errorMsg = touple.message {
            Common.showAlert(message: errorMsg)
        }else{
            updateProfileAPI()
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
            updateUser()
         view.endEditing(true)
        
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
extension MyProfileViewController:CustomPickerViewDelegate{
    func dismissPickerView() {
        
    }
    func didSelectPickerValueAt(title: String, index: Int, pickerType: PickerType?) {
        if let type = pickerType , type == .gendePicker {
            txtFGender.text = title
        }
        if let type = pickerType , type == .cityPicker {
            txtFCity.text = title
        }
    }
}

/*********************************************************************************/
// MARK: CustomDatePicker Deleagte
/*********************************************************************************/
extension MyProfileViewController:CustomDatePickerDelegate{
  
    func didSelectDate(dob: String) {
        txtFDOB.text = dob
    }
}

/*********************************************************************************/
// MARK: API
/*********************************************************************************/
extension MyProfileViewController{
    
    func updateProfileAPI()  {
        LoginService.updateMyProfile(firstname: txtFFirstName.text!,
                                     lastname: txtFLastName.text!,
                                     gender: txtFGender.text!,
                                     dateofbirth: txtFDOB.text!,
                                     handphone: txtFPhoneNumber.text!,
                                     email: txtFEmail.text!,
                                     address1: txtFAddress1.text,
                                     address2: txtFAddress2.text,
                                     city: txtFCity.text,
                                     postalcode: txtFPostalCode.text,
                                     profilePic:imgViewProfilePic.image) { (flag, message) in
                                        if flag {
                                            //Common.showAlert(message: "Profile successfully updated")
                                            NavigationManager.navigateToEvent(navigationController: self.navigationController)
                                        }else{
                                            Common.showAlert(message: message)
                                        }
        }
    }
    
}
