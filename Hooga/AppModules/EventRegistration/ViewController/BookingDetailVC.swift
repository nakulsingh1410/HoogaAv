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
    var details = [SaveBookingDetail]()
    var detailView : BookingDetailView!
    var arrGender = [Gender.male.rawValue,Gender.female.rawValue,Gender.other.rawValue]
    var qnty = 1
    var eventRecord : EventRecord?
    var currentPage = 0
    var arrCity = ["Singapore"]
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        qnty =  (eventRecord?.quantityTicket)!
        addBookingDetailView()
        addTicketBookingView()
        setUIData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setUIData() {
        
        if let evnt = eventRecord?.eventDetail {
            viewTitle.headerView.labelEventTitle.text = evnt.title
            let date = Common.getDateString(strDate:evnt.startdate) + " - " + Common.getDateString(strDate:evnt.enddate)
            let time = Common.getDateString(strDate:evnt.starttime) + " - " + Common.getDateString(strDate:evnt.endtime)
             viewTitle.headerView.labelDateTime.text =  date + " | " + time
             viewTitle.headerView.labelAddress.text = evnt.eventlocation?.trim()
        }
        
        if let ticket = eventRecord?.ticketTypeDetails {
            
            viewTitle.headerView.labelticketType.text = "TICKET TYPE: " + ticket.tickettype!
            if let qnt =  eventRecord?.quantityTicket{
                 viewTitle.headerView.labelQuantity.text = "QUANTITY:" + String(qnt)
            }
            
//            if let price = ticket.regularprice {
//
//                viewTitle.headerView.labelPrice.text = "PRICE:$ " + ticket.regularprice!
//                let total = Float(price)! * qnty
//                viewTitle.headerView.labelTotalPrice.text = "TOTAL:$ " + String(total)
//            }
            
        }
    }
    
    @IBAction func buttonBack_didpressed(button:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
   
        func addBookingDetailView()  {
            let nib = UINib.init(nibName: "BookingDetailView", bundle: nil)
            
            let views = nib.instantiate(withOwner: self, options: nil)
            
            detailView = views[0] as! BookingDetailView
            detailView.frame = CGRect.init(x: 0, y: 0, width: viewBookingDetail.frame.size.width, height: viewBookingDetail.frame.size.height)
            detailView.delegate = self
            viewBookingDetail.addSubview(detailView)
        }
    
    func addTicketBookingView()  {
        
        let nib = UINib.init(nibName: "TicketQuantityView", bundle: nil)
        
        let views = nib.instantiate(withOwner: self, options: nil)
        
        ticketQuantityView = views[0] as? TicketQuantityView
        ticketQuantityView?.delegate = self
        ticketQuantityView?.qunatity = qnty
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
    
    func setDetailModel(ticket : Int) -> Bool  {
        
        let touple =   validate()
        if touple.isEmpty == true , let errorMsg = touple.message {
            Common.showAlert(message: errorMsg)
            return false
        }
        
        let model = SaveBookingDetail()
        model.ticketId   = ticket
        
        model.eventid =   eventRecord?.eventDetail?.eventid
        model.registrationid = eventRecord?.eventDetail?.regid
        model.status = "false"
        model.tickettype = eventRecord?.ticketTypeDetails?.tickettype
        model.tickettypeid = eventRecord?.ticketTypeDetails?.tickettypeid
        model.isearlybird = "false"

        model.address1 = detailView.address1.text
        model.address2 = detailView.address2.text
        model.firstname = detailView.firstName.text
        model.lastname = detailView.lastName.text
        model.email = detailView.email.text
        model.handphone = detailView.mobile.text
        model.postalcode = detailView.postalCode.text
        model.email = detailView.email.text
        model.gender   = detailView.gender.text
        model.dateofbirth = detailView.dob.text
        model.city   = detailView.city.text
        details.append(model)
        
         return true
    }
    
    func updateDetail(detail : SaveBookingDetail)  {
    
         detailView.address1.text = detail.address1
         detailView.address2.text = detail.address2
        detailView.firstName.text = detail.firstname
        detailView.lastName.text = detail.lastname
        detailView.email.text = detail.email
       detailView.mobile.text =  detail.handphone
        detailView.postalCode.text = detail.postalcode
        detailView.email.text = detail.email
        detailView.gender.text = detail.gender
        detailView.dob.text = detail.dateofbirth
        detailView.city.text =  detail.city
    }
    func checkDetail(tId:Int)  -> SaveBookingDetail?{
       return details.filter { $0.ticketId == tId}.first
    }
    
}
extension BookingDetailVC : TicketQuantityViewDelegate ,BookingDetailViewDelegate{
    
    func selectedTicket(ticketView:TicketQuantityView, ticket:Int){
        
        if (checkDetail(tId: ticket - 1) != nil) {
            
        }else{
            detailView.removeFromSuperview()
            addBookingDetailView()
        }
    }
    
    func isTicketCompleted(ticketView:TicketQuantityView, ticket:Int) -> Bool{
        
        if let obj =  checkDetail(tId: ticket - 1)  {
             updateDetail(detail : obj)
            return true
        }
        currentPage = ticket - 1
        return  setDetailModel(ticket: ticket - 1)
    }
    func openGenderPicker(ticketView:BookingDetailView){
        openGenderPicker()
    }
    
    func openDobPicker(ticketView:BookingDetailView){
        openDatePicker()
        
    }
    
    func openCityPicker(ticketView:BookingDetailView){
        openCityPicker()
    }
    func openImagePicker(ticketView:BookingDetailView){
        pickProfileImage()
    }
    func pay(ticketView:BookingDetailView){
        
        if (checkDetail(tId: currentPage) == nil) {
            let isave  =  setDetailModel(ticket: currentPage)
        }
        if details.count == qnty {
            
            saveTicketDetails(arrTicket: details)
        }else{
            Common.showAlert(message: "Please fill ticket deatils")
            
            if (checkDetail(tId: currentPage) == nil) {
                let isave  =  setDetailModel(ticket: currentPage)
            }
            
            saveTicketDetails(arrTicket: details)
            
        }
    }
    func cancel(ticketView:BookingDetailView){
        
        
    }
    
    func saveTicketDetails(arrTicket:[SaveBookingDetail])  {
       TicketBookingService.saveTicketDetails(bookingDetails: arrTicket) { (flag, data) in
            if let _ = data{
                // navigate to payment screen
                self.eventRecord?.bookingDetails =  self.details; NavigationManager.otherPaymentDetail(navigationController: self.navigationController, evntDetail: self.eventRecord!)
            }else{
                //error
        }
            
        }
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
