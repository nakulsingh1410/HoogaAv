//
//  TicketBookingViewController.swift
//  Hooga
//
//  Created by Nakul Singh on 2/2/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class TicketBookingViewController: UIViewController {
    @IBOutlet weak var navHeaderView: CustomNavHeaderView!
    @IBOutlet weak var imgViewBanner: UIImageView!
    
    @IBOutlet weak var lblMaxTicketPerReg: HoogaLabel!
    @IBOutlet weak var lblEventTitle: HoogaLabel!
    @IBOutlet weak var lblEventLocation: HoogaLabel!
    @IBOutlet weak var lblEventTime: HoogaLabel!
    @IBOutlet weak var txtFTicketType: HoogaTextField!
    @IBOutlet weak var txtFQuantity: HoogaTextField!
    
    @IBOutlet weak var imgViewTicket: UIImageView!
    @IBOutlet weak var lblDescription: HoogaLabel!
    
    @IBOutlet weak var lblAvailable: HoogaLabel!

    @IBOutlet weak var lblRegularPrice: HoogaLabel!
    @IBOutlet weak var lblEarlyBird: HoogaLabel!
    @IBOutlet weak var imageVewHeightConstraint: NSLayoutConstraint!
    
    var eventDetail:EventDetail?
    var arrTicketType = [TicketType]()
    var arrQuantity = [String]()
    var availabletTicketsCount : Int = 0
    var ticketTypeDetails:TicketTypeDetails?
    var availableEarlyBirdTicketsCount:Int = 0
    var selectedTicketType : TicketType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configoreNavigationHeader()
        loadDefaultValues()
        if let eventId = eventDetail?.eventid {
            getTicketTypeAPI(eventId:eventId)
        }
//        txtFQuantity.text = ""
    }
    
    func configoreNavigationHeader()  {
            navHeaderView.viewController = self
            navHeaderView.navBarTitle = "Ticket Booking" 
            navHeaderView.backButtonType = .Back
            navHeaderView.isBottonLineHidden = false
        
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
            
            let date = Common.getDateString(strDate:evetDtl.startdate) //+ " - " + Common.getDateString(strDate:evetDtl.enddate)
            let time = Common.getDateString(strDate:evetDtl.starttime) //+ " - " + Common.getDateString(strDate:eventDetail?.endtime)
            lblEventTime.text =  date + " | " + time
        }
        txtFTicketType.text = "Select Ticket"
        txtFQuantity.text = "Select Quantity"
        
       
        
        hideTicketInfo()
        loadQuantity()
    }
    
    func loadQuantity()  {
        if availabletTicketsCount > 0{
            for index in 1 ..< availabletTicketsCount {
                arrQuantity.append("\(index)")
            }
        }
    }
    
    private func openTicketTypePicker(){
        if let picker = CustomPickerView.loadPickerView(){
            picker.frame = view.frame
            picker.pickerType = .ticketTypePicker
            let arrTypes = arrTicketType.map({ (ticket) -> String in
                if let tType = ticket.tickettype{
                    return tType
                }
                return ""
            })
            picker.pickerDataSource = arrTypes
            picker.customPickerViewDelegate = self
            view.addSubview(picker)
        }
    }
    
    private func openQuantityPicker(){
        if let picker = CustomPickerView.loadPickerView(){
            picker.frame = view.frame
            picker.pickerType = .quanityPicker
            picker.pickerDataSource = arrQuantity
            picker.customPickerViewDelegate = self
            view.addSubview(picker)
        }
    }
    
    fileprivate func hideTicketInfo(){
        imageVewHeightConstraint.constant = 0
        lblMaxTicketPerReg.text = ""
        lblDescription.text = ""
        lblAvailable.text = ""
        lblRegularPrice.text = ""
        lblEarlyBird.text = ""
    }
    
    fileprivate func showTicketInfo(){
        
        if let ticketDetail = ticketTypeDetails{
            imageVewHeightConstraint.constant = 128
            
            if let string = ticketDetail.maxticketslimit{
                lblMaxTicketPerReg.text = "*Max Ticket :" +  string + "/ Register"
            }
            
            if let path = ticketDetail.ticketimage {
                let url = kTicketUrl + path
                imgViewTicket.kf.setImage(with: URL(string:url), placeholder: nil, options: nil, progressBlock: nil){[weak self] (image, error, cacheType, url) in
                    guard let weakSelf = self else {return}
                    if image == nil {
                        weakSelf.imgViewTicket.kf.setImage(with: placeHolderImageUrl, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
                    }
                }
            }else{
                imgViewTicket.kf.setImage(with: placeHolderImageUrl, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            }
            if let decsiption = ticketDetail.ticketBooingDescription{
                lblDescription.text = decsiption
                
            }
//            if let string = ticketDetail.maxticketslimit{
                lblAvailable.text = "Available: " + "\(availabletTicketsCount)"
                
//            }
            if let string = ticketDetail.regularprice{
                lblRegularPrice.text =  "Regular Price: " + string
                
            }
            if let string = ticketDetail.earlybirdticketslimit{
                lblEarlyBird.text = "Early Bird Price: " +  string
            }
          
            
            
        }
    }
    private func validate()->(message:String?,isEmpty:Bool){
        
        var message : String?
        if let value = txtFTicketType.text,value == "Select Ticket"{
            message = MessageError.TICKET_TYPE_EMPTY .rawValue
        }else if let value = txtFQuantity.text,value.trimmingCharacters(in: .whitespaces).isEmpty {
            message = MessageError.QUNATITY_TYPE_EMPTY .rawValue
        }else if let value = txtFQuantity.text , value == "Select Quantity"{
            message = MessageError.SELECT_QUNATITY.rawValue
        }

        return (message == nil) ? (message,false):(message,true)
    }
    
    private func proceed()  {
        let touple =   validate()
        if touple.isEmpty == true , let errorMsg = touple.message {
            Common.showAlert(message: errorMsg)
        }else{
            if let evnt = eventDetail{
                
                let record = EventRecord()
                record.eventDetail = evnt
                record.selectedTicketType = selectedTicketType
                record.ticketTypeDetails = ticketTypeDetails
                record.availableEarlyBirdTicketsCount = availableEarlyBirdTicketsCount
                
                if let qnt = txtFQuantity.text{
                    record.quantityTicket = Int(qnt)!
                }
               
        NavigationManager.bookingDetail(navigationController: navigationController, evntDetail: record)
            }
        }
    }

    
    
    @IBAction func btnTicketTypeTappped(_ sender: Any) {
        view.endEditing(true)
        openTicketTypePicker()
    }
    
    @IBAction func btnQuantityTapped(_ sender: Any) {
        view.endEditing(true)
        openQuantityPicker()
    }
    @IBAction func btnProceedTapped(_ sender: Any) {
        view.endEditing(true)
        proceed()
        

        
//        if let evnt = eventDetail{
//            NavigationManager.bookingDetail(navigationController: navigationController, evntDetail: evnt)
//        }
    }
    
}

/*********************************************************************************/
// MARK: CustomPickerView Deleagte
/*********************************************************************************/
extension TicketBookingViewController:CustomPickerViewDelegate{
    
    func dismissPickerView() {
        
    }
    func didSelectPickerValueAt(title: String, index: Int, pickerType: PickerType?) {
        if let type = pickerType , type == .ticketTypePicker {
            txtFTicketType.text = title
            selectedTicketType = arrTicketType[index]
            getTicketTypeDetailsAPI(eventId: (eventDetail?.eventid!)!, tickettypeid: (selectedTicketType!.tickettypeid!))
            getAvailableEarlyBirdTicketsCountAPI(eventId: (eventDetail?.eventid!)!, tickettypeid: (selectedTicketType!.tickettypeid!))
        }
        if let type = pickerType , type == .quanityPicker {
            txtFQuantity.text = title
        }
    }
}


/*********************************************************************************/
// MARK: API
/*********************************************************************************/
extension TicketBookingViewController{
    
    func getTicketTypeAPI(eventId:Int)  {
        EventService.getTicketType(eventid: eventId) { [weak self] (flag, dataArray) in
            guard let weakSelf = self else {return}
            if let array = dataArray{
                weakSelf.arrTicketType = array
            }
        }
        }
    
    func getTicketTypeDetailsAPI(eventId:Int,tickettypeid:Int)  {
        hideTicketInfo()
        EventService.getTicketTypeDetails(eventid: eventId,tickettypeid:tickettypeid) { [weak self] (flag, data) in
            guard let weakSelf = self else {return}
            if let obj = data{
                weakSelf.ticketTypeDetails = obj
//                weakSelf.showTicketInfo()
                weakSelf.getAvailableTicketsCountAPI(eventId: eventId, tickettypeid: tickettypeid)

            }
        }
    }
    
    
    
    func getAvailableTicketsCountAPI(eventId:Int,tickettypeid:Int)  {
        EventService.getAvailableTicketsCount(eventid: eventId, tickettypeid: tickettypeid) { [weak self] (flag, ticketCount) in
            guard let weakSelf = self else {return}
            if let ticketCountInt = ticketCount{
                weakSelf.availabletTicketsCount = ticketCountInt
                weakSelf.loadQuantity()
            }
            weakSelf.showTicketInfo()
        }
    }
    
    
    func getAvailableEarlyBirdTicketsCountAPI(eventId:Int,tickettypeid:Int)  {
       
        EventService.getAvailableEarlyBirdTicketsCount(eventid: eventId,tickettypeid:tickettypeid) { [weak self] (flag, birdTicketsCount) in
            guard let weakSelf = self else {return}
            if let ticketCount = birdTicketsCount{
                weakSelf.availableEarlyBirdTicketsCount = ticketCount
            }
        }
    }
    

}






