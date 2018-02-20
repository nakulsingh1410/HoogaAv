//
//  QcodeTicketVC.swift
//  Hooga
//
//  Created by @mrendra on 04/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class QcodeTicketVC: UIViewController {
    @IBOutlet weak var lblEventTitle: HoogaLabel!
    @IBOutlet weak var lblEventLocation: HoogaLabel!
    @IBOutlet weak var lblEventTime: HoogaLabel!
   
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var navHeaderView : CustomNavHeaderView!
    var eventDetail :EventDetail?
    var  arrQRCodes = [QRCodeTickets]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       configoreNavigationHeader()
        configTableView()
         loadDefaultValues()
        if let eventId =  eventDetail?.eventid,let regid =  eventDetail?.regid{
            showTicketQRCodesAPI(registrationid:regid, eventId: eventId)
        }
        
    }
   
    func configTableView()  {
        
        
        let nib =  UINib(nibName: "QRCodeTableViewCell", bundle: Bundle(for: QRCodeTableViewCell.self))
        tableView.register(nib, forCellReuseIdentifier: "QRCodeTableViewCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.tableFooterView = UIView()
        
    }
    func loadDefaultValues()  {
        if let evetDtl = eventDetail{
            lblEventTitle.text = evetDtl.title
            lblEventLocation.text = evetDtl.eventlocation?.trim()
            let date = Common.getDateString(strDate:evetDtl.startdate) //+ " - " + Common.getDateString(strDate:evetDtl.enddate)
            let time = Common.getDateString(strDate:evetDtl.starttime) //+ " - " + Common.getDateString(strDate:eventDetail?.endtime)
            lblEventTime.text =  date + " | " + time
        }
        lblEventTitle.font = Font.gillSansBold(size: 17)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func configoreNavigationHeader()  {
        navHeaderView.viewController = self
        navHeaderView.navBarTitle = "QR Code(s)"
        navHeaderView.backButtonType = .Back
    }

}

extension QcodeTicketVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrQRCodes.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "QRCodeTableViewCell") as? QRCodeTableViewCell{
            cell.loadCellData(ticketDetails: arrQRCodes[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
}


/*********************************************************************************/
// MARK: APIs
/*********************************************************************************/

extension QcodeTicketVC {
    
    func showTicketQRCodesAPI(registrationid:Int,eventId:Int)  {
        tableView.backgroundView = nil
        
        TicketBookingService.showTicketQRCodes(registrationid: registrationid, eventID: eventId) {[weak self] (flag, array) in
            guard let weakSelf = self else{return}
            
            if let data = array{
                weakSelf.arrQRCodes = data
            }else{
                Common.EmptyMessage(message: "No data available", viewController: weakSelf, tableView: weakSelf.tableView)
            
            }
            weakSelf.tableView.reloadData()
        }
}
}
