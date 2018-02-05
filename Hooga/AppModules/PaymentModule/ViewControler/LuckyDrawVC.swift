//
//  LuckyDrawVC.swift
//  Hooga
//
//  Created by @mrendra on 04/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class LuckyDrawVC: UIViewController {

    
    @IBOutlet weak var lblEventTitle: HoogaLabel!
    @IBOutlet weak var lblEventLocation: HoogaLabel!
    @IBOutlet weak var lblEventTime: HoogaLabel!
    
    @IBOutlet weak var lblDeadLine: HoogaLabel!
    @IBOutlet weak var lblLocation: HoogaLabel!
    @IBOutlet weak var lblConductedOn: HoogaLabel!
    @IBOutlet weak var lblConductedBy: HoogaLabel!
    
    @IBOutlet weak var luckyCode: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lblLuckyDrawNo: HoogaLabel!
    @IBOutlet weak var btnParticipate: HoogaButton!
    
    @IBOutlet weak var navHeaderView : CustomNavHeaderView!
   
    @IBOutlet weak var viewQRcode: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var showMyEventLuckyDraw: ShowMyEventLuckyDraw?
    var arrShowMyEventLuckyDrawPrizes = [ShowMyEventLuckyDrawPrizes]()
    var eventDetail :EventDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         btnParticipate.isHidden = true
        configoreNavigationHeader()
        loadDefaultValues()
        guard let evntdetail = eventDetail else{return}
         showMyEventLuckyDrawStatusAPI(eventId: evntdetail.eventid!)
         showMyEventLuckyDrawAPI(eventId: evntdetail.eventid!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func configoreNavigationHeader()  {
        navHeaderView.viewController = self
        navHeaderView.navBarTitle = "Lucky Draw"
        navHeaderView.backButtonType = .Back
    }
    func loadDefaultValues()  {
        
        if let evetDtl = eventDetail{

            lblEventTitle.text = evetDtl.title
            lblEventLocation.text = evetDtl.eventlocation?.trim()
            
            let date = Common.getDateString(strDate:evetDtl.startdate) + " - " + Common.getDateString(strDate:evetDtl.enddate)
            let time = Common.getDateString(strDate:evetDtl.starttime) + " - " + Common.getDateString(strDate:eventDetail?.endtime)
            lblEventTime.text =  date + " | " + time
        }

    }
    
    
    func showLuckyDrawData()  {
        if let data = showMyEventLuckyDraw{
            
            if let string = data.entrydeadline{
                lblDeadLine.text = "Deadline: " + string
            }
            if let string = data.location{
                lblLocation.text = "Location: "  + string
            }
            if let string = data.heldon{
                lblConductedOn.text = "Conducted On: " + string
            }
            if let string = data.conductedby{
                lblConductedBy.text =  "Conducted By: " + string
            }
        }
    }
    

    @IBAction func buttonParticipat_didPressed(_ sender: Any) {
    }
   

}

/*********************************************************************************/
// MARK: APIs
/*********************************************************************************/

extension LuckyDrawVC {
    
    func showMyEventLuckyDrawStatusAPI(eventId:Int)  {
        TicketBookingService.showMyEventLuckyDrawStatus(eventid: eventId) {[weak self] (flag, status) in
            guard let weakSelf = self else{return}
           
            if let statusFlag = status, statusFlag == "True" {
                 weakSelf.btnParticipate.isHidden = false
            }
            weakSelf.showMyEventLuckyDrawPrizesAPI(eventId: eventId)
        }
    }
  
    func showMyEventLuckyDrawPrizesAPI(eventId:Int)  {
        TicketBookingService.showMyEventLuckyDrawPrizes(eventid: eventId) {[weak self] (flag, array) in
            guard let weakSelf = self else{return}
            
            if let showMyEventLuckyDrawPrizes = array{
                weakSelf.arrShowMyEventLuckyDrawPrizes = showMyEventLuckyDrawPrizes
                // use collection view reload
            }
        }
    }
    
    func showMyEventLuckyDrawAPI(eventId:Int)  {
        TicketBookingService.showMyEventLuckyDraw(eventid: eventId) {[weak self] (flag, showMyEventLuckyDraw) in
            guard let weakSelf = self else{return}
            if let obj = showMyEventLuckyDraw {
                weakSelf.showMyEventLuckyDraw = obj
                weakSelf.showLuckyDrawData()
            }
        }
    }
}

