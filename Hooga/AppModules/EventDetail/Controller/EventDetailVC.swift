//
//  EventDetailVC.swift
//  Hooga
//
//  Created by @mrendra on 28/01/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit



class EventDetailVC: UIViewController{
    @IBOutlet var tableDetail : UITableView!
    
    var eventDetail: EventDetail?
    var arrEventAssets = [EventAssets]()
    var arrEventFlatform = [EventPlatform]()
    var arrEventFaq = [EventFAQ]()
    var arrEventTermsCondition = [EventTersmNCondition]()
    var arrCellType = [Int]()

    var eventID : Int?
    var comingFrom = ComingFromScreen.eventListing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getEventDetail(eventId: eventID!)
        configTableview()
        self.navigationController?.isNavigationBarHidden = false
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
        
        tableDetail.estimatedRowHeight  = 40
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
        return self.arrCellType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellType = -1
        if self.arrCellType.count > indexPath.row {
            
            cellType = self.arrCellType[indexPath.row]
        }
        
        if cellType == 0 {
            let cellBanner = tableView.dequeueReusableCell(withIdentifier: BannerCell.identifier) as! BannerCell
            cellBanner.selectionStyle = .none
            //"ORGANIZED BY: " +
            cellBanner.labelOrganizedBY.text =  (self.eventDetail?.organizer)!.uppercased()
            if let bnanner = self.eventDetail?.bannerimage {
                let url = kImgaeView + bnanner
                cellBanner.imageViewBanner.kf.setImage(with: URL(string:url), placeholder: nil, options: nil, progressBlock: nil){ (image, error, cacheType, url) in
                    if image == nil {
                        cellBanner.imageViewBanner.kf.setImage(with: placeHolderImageUrl, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
                    }
                }
                
            }
            return cellBanner
            
        }else if cellType == 1 {
            let cellTitle = tableView.dequeueReusableCell(withIdentifier: EventTitleCell.identifier) as! EventTitleCell
            //01/01/2018 - 05/01/2018 | 21:00 - 00:00
            cellTitle.labelEvntTitle.text  = self.eventDetail?.title
            let date = Common.getDateString(strDate:eventDetail?.startdate) + " - " + Common.getDateString(strDate:eventDetail?.enddate)
            let time = Common.getDateString(strDate:eventDetail?.starttime) + " - " + Common.getDateString(strDate:eventDetail?.endtime)
            cellTitle.labelDateTime.text =  date + " | " + time
            cellTitle.labelVanue.text = self.eventDetail?.eventlocation?.trim()
            var description =  ""
            
            if let short = eventDetail?.shortdescription?.trim(){
                description += short
            }
            if let long = eventDetail?.longdescription?.trim(){
                description += long
            }
            
            cellTitle.labelDescription.text = description
            if !description.isBlank ,cellTitle.labelDescription.intrinsicContentSize.height > 29{
                cellTitle.btnReadMore.isHidden = false
                cellTitle.readMoreBtnConstraint.constant = 30
            }else{
                cellTitle.btnReadMore.isHidden = true
                cellTitle.readMoreBtnConstraint.constant = 0
            }
            cellTitle.selectionStyle = .none
            return cellTitle
        }else if cellType == 2 {
            let cellContact = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier) as! ContactCell
            
            cellContact.labelPhoneNumber.text = eventDetail?.organizerphone
            cellContact.labelEmailAddress.text = eventDetail?.organizeremail
            cellContact.selectionStyle = .none
            return cellContact
        }else if cellType == 3 {
            let cellGallery = tableView.dequeueReusableCell(withIdentifier: GalleryCell.identifier) as! GalleryCell
            cellGallery.selectionStyle = .none
            cellGallery.arrImageAssets = arrEventAssets
            return cellGallery
        }else if cellType == 4{
            
            let cellShare = tableView.dequeueReusableCell(withIdentifier: ShareCell.identifier) as! ShareCell
            if arrEventFlatform.count > 0{
                cellSharePlateForm(cell: cellShare)
            }
            cellShare.delegate = self
            cellShare.selectionStyle = .none
            if let regId = eventDetail?.regid , regId > 0{
                cellShare.buttonregister.setTitle(RegisterButtonTitle.bookTickets.rawValue, for: .normal)
            }else{
                 cellShare.buttonregister.setTitle(RegisterButtonTitle.register.rawValue, for: .normal)
            }
            cellShare.showShareCell(isComingFrom: comingFrom)
            return cellShare
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

extension EventDetailVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var cellType = -1
        if self.arrCellType.count > indexPath.row {
            cellType = self.arrCellType[indexPath.row]
        }
        if cellType == 0 {
            return UITableViewAutomaticDimension;
        }else if cellType == 1 {
            return UITableViewAutomaticDimension;
        }else if cellType == 2 {
            return 65
        }else if cellType == 3 {
            return UITableViewAutomaticDimension
        }else if cellType == 4{
            return UITableViewAutomaticDimension
        }
        return 0
    }
    
    
}

extension EventDetailVC :ShareCellDelegate{
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
                title == RegisterButtonTitle.register.rawValue
                 {
             NavigationManager.eventRegistration(navigationController: self.navigationController, evntDetail: evntDtl)
            }else if let title = cell.buttonregister.titleLabel?.text ,
                title == RegisterButtonTitle.bookTickets.rawValue{
                NavigationManager.ticketBooking(navigationController: navigationController, evntDetail: evntDtl)
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
                self.arrCellType.append(0)
                self.arrCellType.append(1)
                self.arrCellType.append(2)
                self.tableDetail.reloadData()
            }
            self.getEventAssets(eventId:(self.eventID)!)
        }
        
    }
    ///////
    func getEventAssets(eventId:Int)  {
        
        EventService.getEventAssets(eventid: eventId) { (flag, assestList) in
            if let arrAssets = assestList {
                // usee arrAssets
                self.arrEventAssets = arrAssets
                self.arrCellType.append(3)
                self.tableDetail.reloadData()
            }
            self.getEventPlatforms(eventId:(self.eventID)!)
        }
        
    }
    ///////
    func getEventPlatforms(eventId:Int)  {
        
        EventService.getEventPlatform(eventid: eventId) { (flag, platformList) in
            if let arrPlatforms = platformList {
                // usee arrAssets
                self.arrEventFlatform = arrPlatforms
                if !self.arrCellType.contains(4){
                    self.arrCellType.append(4)
                }
                self.tableDetail.reloadData()
            }
            self.getShowEventFAQs(eventId:(self.eventID)!)
        }
        
    }
    ///////
    func getShowEventFAQs(eventId:Int)  {
        
        EventService.getEventFAQ(eventid: eventId) { (flag, faqs) in
            if let arrFAQs = faqs {
                // usee arrFAQs
                self.arrEventFaq = arrFAQs
                if !self.arrCellType.contains(4){
                    self.arrCellType.append(4)
                }
                self.tableDetail.reloadData()
                self.getShowEventTermsConditions(eventId:(self.eventID)!)
            }
        }
        
    }
    ///////
    func getShowEventTermsConditions(eventId:Int)  {
        
        EventService.getEventTermsConditions(eventid: eventId) { (flag, tersNConditions) in
            if let arrTerms = tersNConditions {
                //usee arrTerms
                self.arrEventTermsCondition = arrTerms
                if !self.arrCellType.contains(4){
                    self.arrCellType.append(4)
                }
                
                self.tableDetail.reloadData()
            }
        }
        
    }
}
