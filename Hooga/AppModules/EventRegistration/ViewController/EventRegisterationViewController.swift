//
//  EventRegisterationViewController.swift
//  Hooga
//
//  Created by Nakul Singh on 1/14/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit


class EventRegisterationViewController: UIViewController {
    
    @IBOutlet weak var lblEventTitle: HoogaLabel!
    @IBOutlet weak var lblEventLocation: HoogaLabel!
    @IBOutlet weak var lblEventTime: HoogaLabel!
    
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
    @IBOutlet weak var imgViewBanner: UIImageView!
    
   fileprivate var arrGender = [Gender.male.rawValue,Gender.female.rawValue]
   fileprivate var arrCity = ["Singapore"]
    var eventDetail:EventDetail?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        txtFCity.text = "Select City"
        loadDefaultValues()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDefaultValues()  {
        if let evetDtl = eventDetail{
            
                if let path = evetDtl.bannerimage {
                    let url = kImgaeView + path
                    imgViewBanner.kf.setImage(with: URL(string:url), placeholder: nil, options: nil, progressBlock: nil){[weak self] (image, error, cacheType, url) in
                        guard let weakSelf = self else {return}
                        if image == nil {
                            weakSelf.imgViewBanner.kf.setImage(with: placeHolderImageUrl, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
                        }
                    }
                }else{
                    imgViewBanner.kf.setImage(with: placeHolderImageUrl, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
                }
            
            lblEventTitle.text = evetDtl.title
            lblEventLocation.text = evetDtl.eventlocation?.trim()
            
            let date = getDateString(strDate:evetDtl.startdate) + " - " + getDateString(strDate:evetDtl.enddate)
            let time = getDateString(strDate:evetDtl.starttime) + " - " + getDateString(strDate:eventDetail?.endtime)
            lblEventTime.text =  date + " | " + time
        }
        
        
    }
    
    func getDateString(strDate:String?) -> String {
        if let string = strDate {
            let array = string.components(separatedBy: " ")
            return array.first!
        }
        return ""
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
    
    private func navigateToEventListing(){
        navigationController?.popToRootViewController(animated: true)
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
        registerUser()
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
extension EventRegisterationViewController:CustomPickerViewDelegate{
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
extension EventRegisterationViewController:CustomDatePickerDelegate{
  
    func didSelectDate(dob: String) {
        txtFDOB.text = dob
    }
}

/*********************************************************************************/
// MARK: API
/*********************************************************************************/
extension EventRegisterationViewController{
    
    func registerAPI()  {
        EventService.eventRegistration(eventid:(eventDetail?.eventid!)!,
                                       firstname: txtFFirstName.text!,
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
                                            weakSelf.navigateToEventListing()
                                            Common.showAlert(message: message)

                                        }else{
                                            Common.showAlert(message: message)
                                        }
        }
    }
    
}
