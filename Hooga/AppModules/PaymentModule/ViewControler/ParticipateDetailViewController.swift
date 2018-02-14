//
//  ParticipateDetailViewController.swift
//  Hooga
//
//  Created by Nakul Singh on 2/7/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class ParticipateDetailViewController: UIViewController {
    @IBOutlet weak var navHeaderView : CustomNavHeaderView!
    
    @IBOutlet weak var lblParticipateName: HoogaLabel!
    @IBOutlet weak var lblLuckyDrawSequence: HoogaLabel!
    @IBOutlet weak var lblLuckyDrawPrice: HoogaLabel!
    @IBOutlet weak var lblIsPriceCollected: HoogaLabel!
    @IBOutlet weak var lblPriceCollectedBy: HoogaLabel!
    @IBOutlet weak var lblCollectedOn: HoogaLabel!
    
    var  participateDetail: ShowMyEventLuckyDrawResult?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configoreNavigationHeader()
         loadParticiapteData()
        
    }
    func configoreNavigationHeader()  {
        navHeaderView.viewController = self
        navHeaderView.navBarTitle = "Lucky Draw Result Details"
        navHeaderView.backButtonType = .Back
    }
    
    
    func loadParticiapteData()  {
        lblParticipateName.text = ""
        lblLuckyDrawSequence.text =  ""
        lblLuckyDrawPrice.text =    ""
        lblPriceCollectedBy.text =   ""
        lblCollectedOn.text = ""
        lblIsPriceCollected.text = ""

        if let data = participateDetail{
            if let string = data.firstName {
                lblParticipateName.text = string
            }
            if let string = data.lastName {
                lblParticipateName.text = lblParticipateName.text! + " " + string
            }
            if let string = data.luckydrawsequence {
                lblLuckyDrawSequence.text =  string
            }
            if let string = data.luckydrawprize {
                lblLuckyDrawPrice.text =    string
            }
            if let string = data.collectedby {
                lblPriceCollectedBy.text =   string
            }
            if let string = data.collectedon {
                lblCollectedOn.text = string.components(separatedBy: " ").first
            }
            if let string = data.isprizecollected {
                lblIsPriceCollected.text = string
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
