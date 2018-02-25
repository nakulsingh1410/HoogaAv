//
//  AddParticipateViewController.swift
//  Hooga
//
//  Created by Nakul Singh on 2/25/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class AddParticipateViewController: UIViewController {
    @IBOutlet weak var eventTicketInfoView: EventInfoTickerView!
    @IBOutlet weak var navHeaderView: CustomNavHeaderView!
    @IBOutlet weak var imgViewBanner: UIImageView!
    
    @IBOutlet weak var txtFQuantity: HoogaTextField!
    
    var eventDetail:EventDetail?
    var comingFrom:ComingFromScreen?
    var arrQuantity = [String]()
    var  ticketTypeDetails = TicketTypeDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let evntdetail = eventDetail else{return}
        eventTicketInfoView.loadTicketInfo(eventDetail: evntdetail, textColor: UIColor.black,backGroundColor: UIColor.clear)
        configoreNavigationHeader()
        loadQuantity()
        loadDefaultValues()
        if let evetDtl = eventDetail,let eventId = evetDtl.eventid{
            getTicketTypeAPI(eventId: eventId)
        }
    }
    func configoreNavigationHeader()  {
        navHeaderView.viewController = self
        navHeaderView.navBarTitle = "Number of Participants"
        if comingFrom == ComingFromScreen.eventRegistration{
            navHeaderView.isBackHandledInController = true
            navHeaderView.customNavHeaderViewDelegate = self
        }
        navHeaderView.backButtonType = .Back
        navHeaderView.isBottonLineHidden = false
        
    }
    
    func loadQuantity()  {
        for index in 1 ..< 20 {
            arrQuantity.append("\(index)")
        }
    }
    
    func loadDefaultValues() {
        if let evetDtl = eventDetail{
            if let path = evetDtl.bannerimage {
                let url = kAssets + path
                imgViewBanner.kf.setImage(with: URL(string:url), placeholder: nil, options: nil, progressBlock: nil){[weak self] (image, error, cacheType, url) in
                    guard let weakSelf = self else {return}
                    if image == nil {
                        weakSelf.imgViewBanner.kf.setImage(with: placeHolderImageUrl, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
                    }
                }
            }else{
                imgViewBanner.kf.setImage(with: placeHolderImageUrl, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
        
        txtFQuantity.text = "1"
    }
    
    private func proceed(){
        var message : String?
        if let value = txtFQuantity.text,value.trimmingCharacters(in: .whitespaces).isEmpty {
            message = MessageError.QUNATITY_TYPE_EMPTY .rawValue
        }else if let value = txtFQuantity.text , value == "Select Quantity"{
            message = MessageError.SELECT_QUNATITY.rawValue
        }
        
        if let  strMessage = message{
            Common.showAlert(message: strMessage)
            
        }else{
            guard let evntdetail = eventDetail else{return}

            let record = EventRecord()
            record.eventDetail = evntdetail
//            record.selectedTicketType = selectedTicketType
            record.ticketTypeDetails = ticketTypeDetails
//            record.availableEarlyBirdTicketsCount = availableEarlyBirdTicketsCount
//
            if let qnt = txtFQuantity.text{
                record.quantityTicket = Int(qnt)!
            }
                 NavigationManager.bookingDetail(navigationController: navigationController, evntDetail: record, comingFrom: ComingFromScreen.addParticipant)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @IBAction func btnQuantityTapped(_ sender: Any) {
        view.endEditing(true)
        openQuantityPicker()
    }
    @IBAction func btnProceedTapped(_ sender: Any) {
        view.endEditing(true)
        proceed()
        
    }
    
}

/*********************************************************************************/
// MARK: CustomPickerView Deleagte
/*********************************************************************************/
extension AddParticipateViewController:CustomPickerViewDelegate{
    
    func dismissPickerView() {
        
    }
    func didSelectPickerValueAt(title: String, index: Int, pickerType: PickerType?) {
        if let type = pickerType , type == .quanityPicker {
            txtFQuantity.text = title
        }
    }
}
extension AddParticipateViewController:CustomNavHeaderViewDelegate{
    func backButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
}


/*********************************************************************************/
// MARK: API
/*********************************************************************************/
extension AddParticipateViewController{
    
    func getTicketTypeAPI(eventId:Int)  {
        EventService.getTicketType(eventid: eventId) { [weak self] (flag, dataArray) in
            guard let weakSelf = self else {return}
            if let array = dataArray{
//                weakSelf.arrTicketType = array
                weakSelf.ticketTypeDetails.tickettypeid = array.first?.tickettypeid
            }
        }
    }
    
}

