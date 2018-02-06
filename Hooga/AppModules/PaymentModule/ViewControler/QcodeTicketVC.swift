//
//  QcodeTicketVC.swift
//  Hooga
//
//  Created by @mrendra on 04/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class QcodeTicketVC: UIViewController {

   
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var navHeaderView : CustomNavHeaderView!
    var eventDetail :EventDetail?
    var  arrQRCodes = [QRCodeTickets]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       configoreNavigationHeader()
        configTableView()
        showTicketQRCodesAPI()
    }
   
    func configTableView()  {
        
        
        let nib =  UINib(nibName: "QRCodeTableViewCell", bundle: Bundle(for: QRCodeTableViewCell.self))
        tableView.register(nib, forCellReuseIdentifier: "QRCodeTableViewCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.tableFooterView = UIView()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func configoreNavigationHeader()  {
        navHeaderView.viewController = self
        navHeaderView.navBarTitle = "Qcode Ticket"
        navHeaderView.backButtonType = .Back
    }

}

extension QcodeTicketVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrQRCodes.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipateTableViewCell") as? ParticipateTableViewCell{
//            cell.loadcellData(ticketDetails: arrTicketDetails[indexPath.row])
//            cell.participateTableViewCellDelegate = self
            return cell
        }
        return UITableViewCell()
    }
    
}


/*********************************************************************************/
// MARK: APIs
/*********************************************************************************/

extension QcodeTicketVC {
    
    func showTicketQRCodesAPI()  {
        TicketBookingService.showTicketQRCodes(arrQRTickets: []) {[weak self] (flag, array) in
            guard let weakSelf = self else{return}
            
            if let data = array{
                weakSelf.arrQRCodes = data
            }
            weakSelf.tableView.reloadData()
        }
}
}
