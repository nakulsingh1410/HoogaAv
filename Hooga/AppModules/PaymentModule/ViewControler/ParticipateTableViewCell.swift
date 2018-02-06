//
//  ParticipateTableViewCell.swift
//  Hooga
//
//  Created by Nakul Singh on 2/6/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit


protocol ParticipateTableViewCellDelegate {
   func participateButtonTapped(cell:ParticipateTableViewCell)
}

class ParticipateTableViewCell: UITableViewCell {

    @IBOutlet weak var lblParticipantName: UILabel!
    @IBOutlet weak var lblParticiapete: UILabel!
    @IBOutlet weak var btnOnPaticipate: UIButton!

    var ticketDetail:ShowMyTicketDetails?
    var participateTableViewCellDelegate:ParticipateTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
       selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadcellData(ticketDetails:ShowMyTicketDetails)  {
        ticketDetail = ticketDetails
        if let string = ticketDetails.firstName{
            lblParticipantName.text = string
        }
        if let string = ticketDetails.lastName{
            lblParticipantName.text =  lblParticipantName.text! + " " + string
        }
        
        if let string = ticketDetails.luckydrawsequence, string.length > 0 {
            lblParticiapete.text = string
            lblParticiapete.backgroundColor = UIColor.gray
            lblParticiapete.textColor = UIColor.white
            btnOnPaticipate.isHidden = true
        }else{
            lblParticiapete.text = " Participate "
            lblParticiapete.backgroundColor = UIColor(hex: "3F81FF")
            lblParticiapete.textColor = UIColor.white
            btnOnPaticipate.isHidden = false
        }
        lblParticiapete.textAlignment = .center
    }
  
    func loadParticipateResultCellData(result:ShowMyEventLuckyDrawResult)  {
        if let string = result.firstName{
            lblParticipantName.text = string
        }
        if let string = result.lastName{
            lblParticipantName.text =  lblParticipantName.text! + " " + string
        }
        
        if let string = result.luckydrawsequence, string.length > 0 {
            lblParticiapete.text = string
            lblParticiapete.backgroundColor = UIColor.gray
            lblParticiapete.textColor = UIColor.white
            btnOnPaticipate.isHidden = true
        }else{
            lblParticiapete.text = " Participate "
            lblParticiapete.backgroundColor = UIColor(hex: "3F81FF")
            lblParticiapete.textColor = UIColor.white
            btnOnPaticipate.isHidden = false
        }
        lblParticiapete.textAlignment = .center
    }
    
    @IBAction func btnParticipateTapped(_ sender: Any) {
        if let _ = ticketDetail{
            participateTableViewCellDelegate?.participateButtonTapped(cell: self)

        }
    }
    
}
