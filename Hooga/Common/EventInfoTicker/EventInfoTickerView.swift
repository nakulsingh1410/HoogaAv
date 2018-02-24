//
//  EventInfoTickerView.swift
//  Hooga
//
//  Created by Nakul Singh on 2/24/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class EventInfoTickerView: UIView {
    
    @IBOutlet weak var lblEventTitle: HoogaLabel!
    @IBOutlet weak var lblEventLocation: HoogaLabel!
    @IBOutlet weak var lblEventTime: HoogaLabel!
    
    private var nibView:UIView!
    
    /******************************************************/
    //MARK: Function
    /******************************************************/
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNib()
        self.nibView.frame = self.bounds
        self.addSubview(nibView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.nibView.frame = self.bounds
    }
    
    private func loadNib() {
        let bundle = Bundle(for: EventInfoTickerView.self)
        if let arrNib = bundle.loadNibNamed("EventInfoTickerView", owner: self, options: nil)?.first as? UIView {
            self.nibView = arrNib
        }
    }
    
    func loadTicketInfo(eventDetail:EventDetail,textColor:UIColor)  {
        lblEventTitle.text = eventDetail.title
        lblEventLocation.text = eventDetail.eventlocation?.trim()
        
        let date = Common.getDateString(strDate:eventDetail.startdate) //+ " - " + Common.getDateString(strDate:evetDtl.enddate)
        let time = Common.getDateString(strDate:eventDetail.starttime) //+ " - " + Common.getDateString(strDate:eventDetail?.endtime)
        lblEventTime.text =  date + " | " + time
        lblEventTitle.font = Font.gillSansBold(size: 17)
        labelTextColors(color: textColor)
    }
    
    
    private func labelTextColors(color:UIColor)  {
        lblEventTitle.textColor = color
        lblEventTime.textColor = color
        lblEventLocation.textColor = color
        if color == .black {
            self.backgroundColor = .white
            nibView.backgroundColor = .white
        }
    }
}
