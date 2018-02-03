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
    
    @IBOutlet weak var lblEventTitle: HoogaLabel!
    @IBOutlet weak var lblEventLocation: HoogaLabel!
    @IBOutlet weak var lblEventTime: HoogaLabel!
    
    @IBOutlet weak var imgViewTicket: UIImageView!
    @IBOutlet weak var lblDescription: HoogaLabel!
    
    @IBOutlet weak var lblAvailable: HoogaLabel!

    @IBOutlet weak var lblRegularPrice: HoogaLabel!
    @IBOutlet weak var lblEarlyBird: HoogaLabel!
    
    var eventDetail:EventDetail?
    var arrEventTyepe = [TicketType]()
    var ticketTypeDetails:TicketTypeDetails?
    var availableCount:Int = 0
    var availableEarlyBirdTicketsCount:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configoreNavigationHeader()
        loadDefaultValues()
        if let eventId = eventDetail?.eventid {
            getEventTypeAPI(eventId:eventId)
        }
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
            
//            let date = getDateString(strDate:evetDtl.startdate) + " - " + getDateString(strDate:evetDtl.enddate)
//            let time = getDateString(strDate:evetDtl.starttime) + " - " + getDateString(strDate:eventDetail?.endtime)
//            lblEventTime.text =  date + " | " + time
        }
//        prefilledUsedData()
        
    }
    
    @IBAction func btnTicketTypeTappped(_ sender: Any) {
    }
    
    @IBAction func btnQuantityTapped(_ sender: Any) {
    }
    @IBAction func btnProceedTapped(_ sender: Any) {
        if let evnt = eventDetail{
            NavigationManager.bookingDetail(navigationController: navigationController, evntDetail: evnt)
        }
    }
    
}
/*********************************************************************************/
// MARK: API
/*********************************************************************************/
extension TicketBookingViewController{
    
    func getEventTypeAPI(eventId:Int)  {
        EventService.getEventType(eventid: eventId) { [weak self] (flag, dataArray) in
            guard let weakSelf = self else {return}
            if let array = dataArray{
                weakSelf.arrEventTyepe = array
                weakSelf.getTicketTypeDetailsAPI(eventId: eventId, tickettypeid: (array.first?.tickettypeid!)!)
            }
        }
        }
    
    func getTicketTypeDetailsAPI(eventId:Int,tickettypeid:Int)  {
        EventService.getTicketTypeDetails(eventid: eventId,tickettypeid:tickettypeid) { [weak self] (flag, data) in
            guard let weakSelf = self else {return}
            if let obj = data{
                weakSelf.ticketTypeDetails = obj
                weakSelf.getAvailableTicketsCountAPI(eventId: eventId)
            }
        }
    }
    
    
    
    func getAvailableTicketsCountAPI(eventId:Int)  {
        EventService.getAvailableTicketsCount(eventid: eventId) { [weak self] (flag, ticketCount) in
            guard let weakSelf = self else {return}
            if let ticketCount = ticketCount{
                weakSelf.availableCount = ticketCount
                weakSelf.getAvailableEarlyBirdTicketsCountAPI(eventId: ticketCount, tickettypeid: 1)
            }
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






