//
//  BookingDetailVC.swift
//  Hooga
//
//  Created by @mrendra on 03/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class BookingDetailVC: UIViewController {
    
    @IBOutlet var viewTitle : CommonHeaderView!
     @IBOutlet var viewQuantity : UIView!
     @IBOutlet var viewBookingDetail : UIView!
    var ticketQuantityView : TicketQuantityView?
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addBookingDetailView()
        addTicketBookingView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttonBack_didpressed(button:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
   
        func addBookingDetailView()  {
            let nib = UINib.init(nibName: "BookingDetailView", bundle: nil)
            
            let views = nib.instantiate(withOwner: self, options: nil)
            
            let detailView = views[0] as! BookingDetailView
            detailView.frame = CGRect.init(x: 0, y: 0, width: viewBookingDetail.frame.size.width, height: viewBookingDetail.frame.size.height)
            
            viewBookingDetail.addSubview(detailView)
        }
    
    func addTicketBookingView()  {
        
        let nib = UINib.init(nibName: "TicketQuantityView", bundle: nil)
        
        let views = nib.instantiate(withOwner: self, options: nil)
        
        ticketQuantityView = views[0] as? TicketQuantityView
        ticketQuantityView?.delegate = self
        ticketQuantityView?.qunatity = 5
        ticketQuantityView?.frame = CGRect.init(x: 0, y: 0, width: viewQuantity.frame.size.width, height: viewQuantity.frame.size.height)
        viewQuantity.addSubview(ticketQuantityView!)
    }
}

extension BookingDetailVC : TicketQuantityViewDelegate {
    
    func selectedTicket(ticketView:TicketQuantityView, ticket:Int){
        
        
    }
    
    func isTicketCompleted(ticketView:TicketQuantityView, ticket:Int) -> Bool{
        
        return true
    }
}
