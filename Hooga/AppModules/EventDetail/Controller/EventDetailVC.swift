//
//  EventDetailVC.swift
//  Hooga
//
//  Created by @mrendra on 28/01/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit


enum EventDetailScreenCell:String{
    case BannerCell = "BannerCell"
    case ContactCell = "ContactCell"
    case EventTitleCell = "EventTitleCell"
    case GalleryCell = "GalleryCell"
    case GalleryImageCell = "GalleryImageCell"
    case ShareCell = "ShareCell"
    case FaqCell = "FaqCell"
}

class EventDetailVC: UIViewController{
    @IBOutlet var tableDetail : UITableView!
    @IBOutlet weak var navHeaderView : CustomNavHeaderView!
    
    var eventDetail: EventDetail?
    var arrEventAssets = [EventAssets]()
    var arrEventFlatform = [EventPlatform]()
    var arrEventFaq = [EventFAQ]()
    var arrEventTermsCondition = [EventTersmNCondition]()
    var arrCellType = [EventDetailScreenCell]()
    
    var eventID : Int?
    var comingFrom = ComingFromScreen.eventListing
    var isTicketBooked = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getRegistrionId(eventId: eventID!)
        
        configTableview()
        configoreNavigationHeader()
        self.navigationController?.isNavigationBarHidden = false
    }
    func configoreNavigationHeader()  {
        navHeaderView.viewController = self
        
        if comingFrom == .eventListing {
            navHeaderView.navBarTitle = "Event Details"

        }else if comingFrom == .bookingDetail || comingFrom == .otherPayment {
            navHeaderView.isBackHandledInController = true
            navHeaderView.customNavHeaderViewDelegate = self
            navHeaderView.navBarTitle = "My Event Details" // My Event Detail

        }else  if comingFrom == .myEvent{
            navHeaderView.navBarTitle = "My Event Details" // My Event Detail
        }else{
            navHeaderView.navBarTitle = "Event Details"
        }
        navHeaderView.backButtonType = .Back
        navHeaderView.isNavBarTransparent = true
        navHeaderView.setLeftMenu()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configTableview()  {
        tableDetail.register(BannerCell.nib, forCellReuseIdentifier: BannerCell.identifier)
        tableDetail.register(EventTitleCell.nib, forCellReuseIdentifier: EventTitleCell.identifier)
        tableDetail.register(ContactCell.nib, forCellReuseIdentifier: ContactCell.identifier)
        tableDetail.register(GalleryCell.nib, forCellReuseIdentifier: GalleryCell.identifier)
        tableDetail.register(ShareCell.nib, forCellReuseIdentifier: ShareCell.identifier)
        tableDetail.separatorStyle = .none
        tableDetail.rowHeight = UITableViewAutomaticDimension
        
        tableDetail.estimatedRowHeight  = 44
        tableDetail.tableFooterView     = UIView()
        tableDetail.delegate            = self
        tableDetail.dataSource          = self
    }
    
    
    @IBAction func buttonBack_didpressed(button:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

extension EventDetailVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCellType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType = arrCellType[indexPath.row]
        switch cellType {
        case .BannerCell:
            return getBannerCell()
        case .EventTitleCell:
            return getEventTitleCell()
        case .ContactCell:
            return getContactCell()
        case .GalleryCell:
            return getGalleryCell()
        case .ShareCell:
            return getShareCell()
        default:
            return UITableViewCell()
        }
    }
}
extension EventDetailVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

//MARK: Get Table view cells
extension EventDetailVC{
    
    func getBannerCell() -> UITableViewCell {
        if let cell = tableDetail.dequeueReusableCell(withIdentifier: BannerCell.identifier) as? BannerCell {
            if let eventDetail = eventDetail{
                cell.loadCellData(eventDetail: eventDetail)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    
    
    func getEventTitleCell() -> UITableViewCell {
        if let cell = tableDetail.dequeueReusableCell(withIdentifier: EventTitleCell.identifier) as? EventTitleCell {
            if let eventDetail = eventDetail{
                cell.loadCellData(eventDetail: eventDetail)
            }
            cell.eventTitleCellDelegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func getContactCell() -> UITableViewCell {
        if let cell = tableDetail.dequeueReusableCell(withIdentifier: ContactCell.identifier) as? ContactCell {
            if let eventDetail = eventDetail{
                cell.loadCellData(eventDetail: eventDetail)
            }
            return cell
        }
        return UITableViewCell()
    }
    func getGalleryCell() -> UITableViewCell {
        if let cell = tableDetail.dequeueReusableCell(withIdentifier: GalleryCell.identifier) as? GalleryCell {
            cell.arrImageAssets = arrEventAssets
            return cell
        }
        return UITableViewCell()
    }
    
    func getShareCell() -> UITableViewCell {
        if let cell = tableDetail.dequeueReusableCell(withIdentifier: ShareCell.identifier) as? ShareCell {

            cell.loadCellData(arrEventFlatform: arrEventFlatform, eventDetail: eventDetail, isComingFrom: comingFrom, isTicketBooked: isTicketBooked)
            cell.btnTermsNCondition.isHidden = true
            cell.btnFAQs.isHidden = true
            
            if arrEventFaq.count > 0 {
                cell.btnFAQs.isHidden = false
            }
            if arrEventTermsCondition.count > 0 {
                cell.btnTermsNCondition.isHidden = false
            }
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    
    func cellSharePlateForm(cell : ShareCell)  {
        
        cell.buttnFaceBook.isHidden = true
        cell.buttonTwitter.isHidden = true
        cell.buttonInsta.isHidden = true
        cell.buttonGoogle.isHidden = true
        for item in arrEventFlatform {
            if item.platform == "Facebook"{
                cell.buttnFaceBook.url = item.url
                cell.buttnFaceBook.isHidden = false
            }else if item.platform ==  "Twitter"{
                cell.buttonTwitter.url = item.url
                cell.buttonTwitter.isHidden = false
            }else if item.platform ==  "Instagram"{
                cell.buttonInsta.url = item.url
                cell.buttonInsta.isHidden = false
            }else if item.platform ==  "Goggle"{
                cell.buttonGoogle.url = item.url
                cell.buttonGoogle.isHidden = false
            }
        }
    }
    
    
}

extension EventDetailVC:EventTitleCellDelegate{
    
    func readMoreTapped(cell: EventTitleCell) {
        var longDescription =  ""
        if let long = eventDetail?.longdescription?.trim(){
            longDescription += long
        }
        NavigationManager.navigateToLongDescription(navigationController: navigationController, longDescription: longDescription)
    }
}

extension EventDetailVC :ShareCellDelegate{
    func bookMoreDidSelected(cell: ShareCell) {
        guard let evntDtl = eventDetail else{return}
        NavigationManager.ticketBooking(navigationController: navigationController, evntDetail: evntDtl, comingFrom: ComingFromScreen.eventDetail)
    }
    
    func viewTicketDidSelected(cell: ShareCell) {
        if let eventDetailObj = eventDetail{
            NavigationManager.QRCode(navigationController: navigationController, evntDetail: eventDetailObj)
        }
        
    }
    
    func luckyDrawDidSelected(cell: ShareCell) {
        if let eventDetailObj = eventDetail{
            NavigationManager.luckyDraw(navigationController: navigationController, evntDetail: eventDetailObj)
        }
    }
    
    func registerBttonSelected(cell: ShareCell) {
        guard let evntDtl = eventDetail else{return}
        if let title = cell.buttonregister.titleLabel?.text ,
            title == RegisterButtonTitle.register.rawValue{
            NavigationManager.eventRegistration(navigationController: self.navigationController, evntDetail: evntDtl)
        }else if let title = cell.buttonregister.titleLabel?.text ,
            title == RegisterButtonTitle.bookTickets.rawValue || title == RegisterButtonTitle.bookMoreTicket.rawValue{
            NavigationManager.ticketBooking(navigationController: navigationController, evntDetail: evntDtl, comingFrom: ComingFromScreen.eventDetail)
        }else if let title = cell.buttonregister.titleLabel?.text ,
            title == RegisterButtonTitle.addParticipants.rawValue || title == RegisterButtonTitle.addMoreParticipants.rawValue{
            NavigationManager.navigateToAddParticipate(navigationController: navigationController, evntDetail: evntDtl, comingFrom: ComingFromScreen.eventDetail)
        }
    }
    
    func faqSelected() {
        
        if arrEventFaq.count > 0 {
            let faqVc = self.storyboard?.instantiateViewController(withIdentifier: "FaqVC") as! FaqVC
            faqVc.arrFaq = arrEventFaq
            self.navigationController?.pushViewController(faqVc, animated: true)
        }
        
    }
    
    func termSelected() {
        if arrEventTermsCondition.count > 0 {
            let faqVc = self.storyboard?.instantiateViewController(withIdentifier: "FaqVC") as! FaqVC
            faqVc.arrTermsCondition = arrEventTermsCondition
            self.navigationController?.pushViewController(faqVc, animated: true)
        }
    }
}

extension EventDetailVC {
    
    func getEventDetail(eventId:Int)  {
        
        EventService.getEventDetail(eventid: eventId) { (flag, eventdetail) in
            if let detail = eventdetail {
                // usee detail
                self.eventDetail =  detail
                self.arrCellType.append(EventDetailScreenCell.BannerCell)
                self.arrCellType.append(EventDetailScreenCell.EventTitleCell)
                self.arrCellType.append(EventDetailScreenCell.ContactCell)
                self.tableDetail.reloadData()
            }
            self.getEventAssets(eventId:(self.eventID)!)
        }
        
    }

    func getEventAssets(eventId:Int)  {
        
        EventService.getEventAssets(eventid: eventId) { (flag, assestList) in
            if let arrAssets = assestList {
                // usee arrAssets
                self.arrEventAssets = arrAssets
                self.arrCellType.append(EventDetailScreenCell.GalleryCell)
                //                self.arrCellType.append(3)
                self.tableDetail.reloadData()
            }
            self.getEventPlatforms(eventId:(self.eventID)!)
        }
        
    }

    func getEventPlatforms(eventId:Int)  {
        
        EventService.getEventPlatform(eventid: eventId) { (flag, platformList) in
            if let arrPlatforms = platformList {
                // usee arrAssets
                self.arrEventFlatform = arrPlatforms
                if !self.arrCellType.contains(EventDetailScreenCell.ShareCell){
                    self.arrCellType.append(EventDetailScreenCell.ShareCell)
                }
                self.tableDetail.reloadData()
            }
            self.getShowEventFAQs(eventId:(self.eventID)!)
        }
        
    }

    func getShowEventFAQs(eventId:Int)  {
        
        EventService.getEventFAQ(eventid: eventId) { (flag, faqs) in
            if let arrFAQs = faqs {
                // usee arrFAQs
                self.arrEventFaq = arrFAQs
                if !self.arrCellType.contains(EventDetailScreenCell.ShareCell){
                    self.arrCellType.append(EventDetailScreenCell.ShareCell)
                }
                
            }
            //                self.tableDetail.reloadData()
            
            self.getShowEventTermsConditions(eventId:(self.eventID)!)
            
        }
        
    }

    func getShowEventTermsConditions(eventId:Int)  {
        
        EventService.getEventTermsConditions(eventid: eventId) { (flag, tersNConditions) in
            if let arrTerms = tersNConditions {
                //usee arrTerms
                self.arrEventTermsCondition = arrTerms
            }
            if !self.arrCellType.contains(EventDetailScreenCell.ShareCell){
                self.arrCellType.append(EventDetailScreenCell.ShareCell)
            }
            self.tableDetail.reloadData()
        }
    }
    
    func getRegistrionId(eventId:Int)  {
        
        EventService.getRegistrationId(eventid: eventId) { (flag, regId) in
            if let regID = regId{
                self.isTicketBooked(eventId: eventId, registrationid: regID)
            }else{
                self.getEventDetail(eventId: eventId)
            }
        }
        
    }
    
    func isTicketBooked(eventId:Int,registrationid:Int)  {
        
        EventService.isTicketBooked(eventid: eventId, registrationid: registrationid) { (flag, status) in
            if let message = status , message == "Yes"{
                self.isTicketBooked = true
            }else{
                self.isTicketBooked = false
            }
            self.getEventDetail(eventId: eventId)
        }
        
        
    }
}
/*********************************************************************************/
// MARK: CustomNavHeaderViewDelegate
/*********************************************************************************/
extension EventDetailVC:CustomNavHeaderViewDelegate{
    func backButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
//        if comingFrom == .bookingDetail || comingFrom == .otherPayment {
//            NavigationManager.navigateToMyEvent(navigationController: navigationController, screenShown: .bookingDetail)
//        }
    }
}
