//
//  EventTitleCell.swift
//  Hooga
//
//  Created by @mrendra on 28/01/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

protocol EventTitleCellDelegate {
    func readMoreTapped(cell:EventTitleCell)
}

class EventTitleCell: UITableViewCell {

    
    @IBOutlet weak var labelEvntTitle: UILabel!
    
    @IBOutlet weak var labelDateTime: UILabel!
    
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelVanue: UILabel!
    @IBOutlet weak var readMoreBtnConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnReadMore: UIButton!
    var eventTitleCellDelegate:EventTitleCellDelegate?
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCellData(eventDetail:EventDetail)  {
        
        labelEvntTitle.text  = eventDetail.title
        let date = Common.getDateString(strDate:eventDetail.startdate) + " - " + Common.getDateString(strDate:eventDetail.enddate)
        let time = Common.getDateString(strDate:eventDetail.starttime) + " - " + Common.getDateString(strDate:eventDetail.endtime)
        labelDateTime.text =  date + " | " + time
        labelVanue.text = eventDetail.eventlocation?.trim()
        
        var categoryString = ""
        if let category =  eventDetail.category{
            categoryString = category
        }
        if let entrytype =  eventDetail.entrytype{
            categoryString = categoryString + " | " + entrytype
        }
        lblCategory.text = categoryString
        
        var shortDescription =  ""
        if let short = eventDetail.shortdescription?.trim(){
            shortDescription += short
        }
        labelDescription.text = shortDescription
        
        var longDescription =  ""
        if let long = eventDetail.longdescription?.trim(){
            longDescription += long
        }
        
        if longDescription.length > 0{
            btnReadMore.isHidden = false
            readMoreBtnConstraint.constant = 30
        }else{
            btnReadMore.isHidden = true
            readMoreBtnConstraint.constant = 0
        }
    }
    
    @IBAction func btnReadMoreTapped(_ sender: Any) {
        eventTitleCellDelegate?.readMoreTapped(cell: self)
    }
}
