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
    func participateDetailButtonTapped(cell:ParticipateTableViewCell)

}

class ParticipateTableViewCell: UITableViewCell {

    @IBOutlet weak var lblParticipantName: UILabel!
    @IBOutlet weak var lblParticiapete: UILabel!
    @IBOutlet weak var btnOnPaticipate: UIButton!
    @IBOutlet weak var btnDetail: UIButton!
    @IBOutlet weak var heightConstraintDetailBtn: NSLayoutConstraint!
    
    var ticketDetail:ShowMyTicketDetails?
   var  showMyEventLuckyDrawResult:ShowMyEventLuckyDrawResult?
    var participateTableViewCellDelegate:ParticipateTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
       selectionStyle = .none
        heightConstraintDetailBtn.constant = 0
        btnDetail.isHidden = true
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
        showMyEventLuckyDrawResult = result
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
        
          if let string = result.isprizewon, string == "True" {
            heightConstraintDetailBtn.constant = 30
            btnDetail.isHidden = false

          }else{
            heightConstraintDetailBtn.constant = 0
            btnDetail.isHidden = true
        }
        lblParticiapete.textAlignment = .center
        layoutIfNeeded()

        
    }
    
    
    
    
    
    @IBAction func btnParticipateTapped(_ sender: Any) {
        if let _ = ticketDetail{
            participateTableViewCellDelegate?.participateButtonTapped(cell: self)

        }
    }
    
    
    @IBAction func btnDetailTapped(_ sender: Any) {
        if let _ = showMyEventLuckyDrawResult{
            participateTableViewCellDelegate?.participateDetailButtonTapped(cell: self)
            
        }
    }
}
