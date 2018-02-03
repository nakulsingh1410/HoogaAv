//
//  BookingDetailVC.swift
//  Hooga
//
//  Created by @mrendra on 03/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class BookingDetailVC: UIViewController {
    
    @IBOutlet var viewTitle : CommonHeaderView!
     @IBOutlet var viewQuantity : UIView!
     @IBOutlet var viewBookingDetail : UIView!
    var ticketQuantityView : TicketQuantityView?
    var details = [BookingDetail]()
    var detailView : BookingDetailView!
    var arrGender = [Gender.male.rawValue,Gender.female.rawValue,Gender.other.rawValue]
    
    var arrCity = ["Singapore"]
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addBookingDetailView()
        addTicketBookingView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttonBack_didpressed(button:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
   
        func addBookingDetailView()  {
            let nib = UINib.init(nibName: "BookingDetailView", bundle: nil)
            
            let views = nib.instantiate(withOwner: self, options: nil)
            
            detailView = views[0] as! BookingDetailView
            detailView.frame = CGRect.init(x: 0, y: 0, width: viewBookingDetail.frame.size.width, height: viewBookingDetail.frame.size.height)
            
            viewBookingDetail.addSubview(detailView)
        }
    
    func addTicketBookingView()  {
        
        let nib = UINib.init(nibName: "TicketQuantityView", bundle: nil)
        
        let views = nib.instantiate(withOwner: self, options: nil)
        
        ticketQuantityView = views[0] as? TicketQuantityView
        ticketQuantityView?.delegate = self
        ticketQuantityView?.qunatity = 5
        ticketQuantityView?.frame = CGRect.init(x: 0, y: 0, width: viewQuantity.frame.size.width, height: viewQuantity.frame.size.height)
        viewQuantity.addSubview(ticketQuantityView!)
    }
    
    private func validate()->(message:String?,isEmpty:Bool){
        
        var message : String?
        if let value = detailView.firstName.text,value.trimmingCharacters(in: .whitespaces).isEmpty{
            message = MessageError.USER_FIRST_NAME_BLANK .rawValue
        }else if let value = detailView.lastName.text,value.trimmingCharacters(in: .whitespaces).isEmpty {
            message = MessageError.USER_LAST_NAME_BLANK .rawValue
        }else if let value = detailView.gender.text,value.trimmingCharacters(in: .whitespaces).isEmpty {
            message = MessageError.USER_GENDER_BLANK .rawValue
        }else if let value = detailView.dob.text,value == "__/ __/ __" {
            message = MessageError.USER_DOB_BLANK .rawValue
        }else if let value = detailView.mobile.text,value.trimmingCharacters(in: .whitespaces).isEmpty {
            message = MessageError.PHONE_EMPTY .rawValue
        }else if let value = detailView.email.text,value.trimmingCharacters(in: .whitespaces).isEmpty {
            message = MessageError.EMAIL_BLANK.rawValue
        }else if let value = detailView.email.text,value.isEmail == false{
            message = MessageError.EMAIL_INVALID.rawValue
        }
//        else if let value = detailView.address1.text,value.trimmingCharacters(in: .whitespaces).isEmpty {
//                    message = MessageError.ADDRESS1_BLANK .rawValue
//                }else if let value = detailView.address2.text,value.trimmingCharacters(in: .whitespaces).isEmpty {
//                    message = MessageError.ADDRESS2_BLANK .rawValue
//                }else if let value = detailView.city.text,value.trimmingCharacters(in: .whitespaces).isEmpty {
//                    message = MessageError.CITY_EMPTY.rawValue
//                }else if let value = detailView.postalCode.text,value.trimmingCharacters(in: .whitespaces).isEmpty {
//                    message = MessageError.POSTCODE_EMPTY.rawValue
//                }
         return (message == nil) ? (message,false):(message,true)
   }
    
    private func addDetail()  {
        let touple =   validate()
        if touple.isEmpty == true , let errorMsg = touple.message {
            Common.showAlert(message: errorMsg)
        }else{
            
        }
    }
}
extension BookingDetailVC : TicketQuantityViewDelegate {
    
    func selectedTicket(ticketView:TicketQuantityView, ticket:Int){
        
        
    }
    
    func isTicketCompleted(ticketView:TicketQuantityView, ticket:Int) -> Bool{
        
        return true
    }
}

extension BookingDetailVC {
    
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
    
    
    private func pickProfileImage(){
        let imageController = OpenImagePickerViewController()
        imageController.configure {[weak self]  (flag, image) in
            guard let weakSelf = self else {return}
            if flag {
//                weakSelf.imgViewProfilePic.image = image
//                weakSelf.btnUpload.isHidden = true
            }
            else{
                
            }
        }
        let vcObj = appDelegate.window?.visibleViewController
        vcObj?.present(imageController, animated: true, completion: nil);
    }
}


/******************************************/
// MARK: CustomPickerView Deleagte
/*********************************************************************************/
extension BookingDetailVC:CustomPickerViewDelegate{
    func dismissPickerView() {
        
    }
    func didSelectPickerValueAt(title: String, index: Int, pickerType: PickerType?) {
        if let type = pickerType , type == .gendePicker {
            detailView.gender.text = title
        }
        if let type = pickerType , type == .cityPicker {
            detailView.city.text = title
        }
    }
}

/*********************************************************************************/
// MARK: CustomDatePicker Deleagte
/*********************************************************************************/
extension BookingDetailVC:CustomDatePickerDelegate{
    
    func didSelectDate(dob: String) {
        detailView.dob.text = dob
    }
}


/*
 
 Use this code on click on PAY button 
 
 func saveTicketDetails()  {
 
 var arrTickets = [SaveBookingDetail]()
 arrTickets.append(SaveBookingDetail())
 arrTickets.append(SaveBookingDetail())
 arrTickets.append(SaveBookingDetail())
 arrTickets.append(SaveBookingDetail())
 
 TicketBookingService.saveTicketDetails(bookingDetails: arrTickets) { (flag, data) in
 
 if let _ = data{
 // navigate to payment screen
 }
 
 }
 }
 
 
 */
