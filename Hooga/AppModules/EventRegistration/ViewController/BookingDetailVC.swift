//
//  BookingDetailVC.swift
//  Hooga
//
//  Created by @mrendra on 03/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class BookingDetailVC: UIViewController {
    
    @IBOutlet var viewQuantity : UIView!
    @IBOutlet var viewBookingDetail : UIView!
    
    @IBOutlet weak var labelticketType: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelQuantity: UILabel!
    @IBOutlet weak var labelTotalPrice: UILabel!
    @IBOutlet weak var ticketQuantityHeightConstraint: NSLayoutConstraint!
    
    var ticketQuantityView : TicketQuantityView?
    var arrBookingDetails = [SaveBookingDetail]()
    var detailView : BookingDetailView!
    var arrGender = [Gender.male.rawValue,Gender.female.rawValue,Gender.other.rawValue]
    var qnty = 1
    var eventRecord : EventRecord?
    var currentPage = 0
    var presentedViewIndex = 0
    var arrCity = ["Singapore"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        qnty =  (eventRecord?.quantityTicket)!
        addBookingDetailView()
        addTicketBookingView()
        setUIData()
        configureData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUIData() {
        if let ticket = eventRecord?.ticketTypeDetails {
            labelticketType.text = "Ticket Type: " + ticket.tickettype!
            if let qnt =  eventRecord?.quantityTicket{
                labelQuantity.text = "Qty:" + String(qnt)
            }
            if let price = ticket.regularprice {
                labelPrice.text = "Price:$ " + price
                let total = Float(price)! * Float(qnty)
                labelTotalPrice.text = "Total:$ " + String(total)
            }
        }
        if qnty == 1 {
            ticketQuantityHeightConstraint.constant = 0
        }else{
            ticketQuantityHeightConstraint.constant = 50
        }
       
    }
    
    
    func configureData()  {
        arrBookingDetails.append(loadFirstTicketData())
        for _ in 1 ..< qnty {
            arrBookingDetails.append(SaveBookingDetail())
        }
        if let first = arrBookingDetails.first {
            updateDetail(detail: first)
        }
    }
    
    func loadFirstTicketData()->SaveBookingDetail  {
        let bookingModel = SaveBookingDetail()
        if let userData = StorageModel.getUserData(){
            bookingModel.firstname = userData.firstname
            bookingModel.lastname = userData.lastname
            bookingModel.gender = userData.gender
            bookingModel.handphone = userData.handphone
            bookingModel.dateofbirth = userData.dateofbirth
            bookingModel.email = userData.email
            bookingModel.address1 = userData.address1
            bookingModel.address2 = userData.address2
            bookingModel.city = userData.city
            bookingModel.postalcode = userData.postalcode
            bookingModel.isBookingDetailFilled = true
            bookingModel.ticketId = 0
            if let bnanner = userData.profilepic {
//                let url = kImgaeView + bnanner
//                imgViewProfilePic.kf.setImage(with: URL(string:url), placeholder: nil, options: nil, progressBlock: nil){ (image, error, cacheType, url) in
//                    if image == nil {
//                        self.btnUpload.isHidden = false
//                    }
//                }
            }
        }
        return bookingModel
    }
    
    
    @IBAction func buttonBack_didpressed(button:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func addBookingDetailView(tabIndex:Int = 0)  {
        let nib = UINib.init(nibName: "BookingDetailView", bundle: nil)
        let views = nib.instantiate(withOwner: self, options: nil)
        detailView = views[0] as! BookingDetailView
        detailView.frame = CGRect.init(x: 0, y: 0, width: viewBookingDetail.frame.size.width, height: viewBookingDetail.frame.size.height)
        detailView.delegate = self
        viewBookingDetail.addSubview(detailView)
        presentedViewIndex = tabIndex
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
        }else if let value = detailView.mobile.text,!value.isPhoneValid(){
            message = MessageError.PHONE_INVALID .rawValue
        }
//        else if let value = detailView.email.text,value.trimmingCharacters(in: .whitespaces).isEmpty {
//            message = MessageError.EMAIL_BLANK.rawValue
//        }else if let value = detailView.email.text,value.isEmail == false{
//            message = MessageError.EMAIL_INVALID.rawValue
//        }

        return (message == nil) ? (message,false):(message,true)
    }
    
    func updateDetail(detail : SaveBookingDetail)  {
        
        detailView.address1.text = detail.address1
        detailView.address2.text = detail.address2
        detailView.firstName.text = detail.firstname
        detailView.lastName.text = detail.lastname
        detailView.email.text = detail.email
        detailView.mobile.text =  detail.handphone
        detailView.postalCode.text = detail.postalcode
        detailView.gender.text = detail.gender
        detailView.dob.text = detail.dateofbirth
        detailView.city.text =  detail.city
    }
    func getTicketForTicketId(ticketId:Int)  -> SaveBookingDetail?{
        return arrBookingDetails.filter { $0.ticketId == ticketId}.first
    }
    
    
}
extension BookingDetailVC{
    
    func saveTicketDetailInModel(ticketId:Int)  {
        
        let model = SaveBookingDetail()
        model.ticketId = ticketId
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
        arrBookingDetails[ticketId] = model

        let touple =   validate()
        if touple.isEmpty == true , let _ = touple.message {
            model.ticketId = -1
        }
        
    }
    
    func clearCurrentTicketDetail()  {
        arrBookingDetails[presentedViewIndex] = SaveBookingDetail()
        updateDetail(detail: arrBookingDetails[presentedViewIndex])
//        detailView.address1.text = detail.address1
//        detailView.address2.text = detail.address2
//        detailView.firstName.text = detail.firstname
//        detailView.lastName.text = detail.lastname
//        detailView.email.text = detail.email
//        detailView.mobile.text =  detail.handphone
//        detailView.postalCode.text = detail.postalcode
//        detailView.gender.text = detail.gender
//        detailView.dob.text = detail.dateofbirth
//        detailView.city.text =  detail.city
    }
    
}

/****************************************************************/
// MARK: TicketQuantityView Delegate
/**********************************************************************/
extension BookingDetailVC : TicketQuantityViewDelegate ,BookingDetailViewDelegate{
    func didSelectRowAt(indexpath: IndexPath,ticektQuantityView:TicketQuantityView) {
        
        if presentedViewIndex == indexpath.row {
            return
        }
        let _ = saveTicketDetailInModel(ticketId: presentedViewIndex)
        if let ticket = getTicketForTicketId(ticketId: indexpath.row){
            detailView.removeFromSuperview()
            addBookingDetailView(tabIndex: indexpath.row)
            updateDetail(detail: ticket)
            ticektQuantityView.indexPth = indexpath
            ticektQuantityView.collectionQuantity.reloadData()
            return
        }
        
        detailView.removeFromSuperview()
        addBookingDetailView(tabIndex: indexpath.row)
        updateDetail(detail: arrBookingDetails[indexpath.row])
        ticektQuantityView.indexPth = indexpath
        ticektQuantityView.collectionQuantity.reloadData()

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
    func submit(ticketView:BookingDetailView){
        
        if validate().isEmpty == true {
            Common.showAlert(message: validate().message!)
            return
        }else{
            let _ = saveTicketDetailInModel(ticketId: presentedViewIndex)

            let unFilledTickets = arrBookingDetails.filter({ (bookingDetail) -> Bool in
                return bookingDetail.ticketId == -1
            })
            if unFilledTickets.count > 0{
                Common.showAlert(message: "Please fill ALL ticket info completly")
            }else{
                self.saveTicketDetailsAPI(arrTicket: self.arrBookingDetails)
            }
            
        }
    }
    
    func cancel(ticketView:BookingDetailView){
        
        clearCurrentTicketDetail()

    }
    func saveTicketDetailsAPI(arrTicket:[SaveBookingDetail])  {
        TicketBookingService.saveTicketDetails(bookingDetails: arrTicket) { (flag, data) in
            if let reponseArray = data{
                // navigate to payment screen
                self.eventRecord?.bookingDetails =  self.arrBookingDetails;
                NavigationManager.otherPaymentDetail(navigationController: self.navigationController, evntDetail: self.eventRecord!, savedTicketDetail: reponseArray)
            }else{
                //error
            }
            
        }
    }
}

/****************************************************************/
// MARK: Open picker
/**********************************************************************/

extension BookingDetailVC {
    
    private func openGenderPicker(){
        view.endEditing(true)
        if let picker = CustomPickerView.loadPickerView(){
            picker.frame = view.frame
            picker.pickerType = .gendePicker
            picker.pickerDataSource = arrGender
            picker.customPickerViewDelegate = self
            view.addSubview(picker)
        }
    }
    private func openCityPicker(){
        view.endEditing(true)
        if let picker = CustomPickerView.loadPickerView(){
            picker.frame = view.frame
            picker.pickerType = .cityPicker
            picker.pickerDataSource = arrCity
            picker.customPickerViewDelegate = self
            view.addSubview(picker)
        }
    }
    private func openDatePicker(){
        view.endEditing(true)
        if let picker = CustomDatePicker.loadDatePickerView(){
            picker.frame = view.frame
            picker.customDatePickerDelegate = self
            
            view.addSubview(picker)
        }
    }
    
    
    private func pickProfileImage(){
        view.endEditing(true)
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


/****************************************************************/
// MARK: CustomPickerView Deleagte
/**********************************************************************/
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
