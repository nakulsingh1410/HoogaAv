//
//  QRCodeTableViewCell.swift
//  Hooga
//
//  Created by Nakul Singh on 2/6/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit
import Kingfisher
class QRCodeTableViewCell: UITableViewCell {
  
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTicketType: UILabel!
    @IBOutlet weak var lblQrCode: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadCellData(ticketDetails:QRCodeTickets)  {
        
        
        if let string = ticketDetails.firstName {
            lblName.text = string
        }
        if let string = ticketDetails.lastName {
            lblName.text = lblName.text! + " " + string
        }
        if let string = ticketDetails.tickettype {
            lblTicketType.text =   string
        }else{
            lblTicketType.text = ""
        }
        
        if let string = ticketDetails.qrCode {
            lblQrCode.text =   string
        }else{
            lblQrCode.text = ""
        }
        
        
        
        if let bnanner = ticketDetails.qrCodeImage {
            let url = kQRCodes + bnanner
            cardImage.kf.setImage(with: URL(string:url), placeholder: nil, options: nil, progressBlock: nil){ (image, error, cacheType, url) in
                if image == nil {
                    self.cardImage.kf.setImage(with: placeHolderImageUrl, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
            
        }
    }
}
