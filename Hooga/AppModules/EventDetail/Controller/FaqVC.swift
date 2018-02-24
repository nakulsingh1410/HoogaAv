//
//  FaqVC.swift
//  Hooga
//
//  Created by @mrendra on 30/01/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class FaqVC: UIViewController {

    @IBOutlet weak var tableFaq : UITableView!
    @IBOutlet var labelTitle : UILabel!
    var arrFaq = [EventFAQ]()
    var arrTermsCondition = [EventTersmNCondition]()
    
        override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configFaqTableview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configFaqTableview()  {
       
        if arrFaq.count != 0 {
            
             labelTitle.text = "FAQs"
        }else{
            labelTitle.text = "Terms & Conditions"
        }
       // tableFaq.register(FaqCell.self, forCellReuseIdentifier: FaqCell.identifier)
        tableFaq.rowHeight = UITableViewAutomaticDimension
        tableFaq.estimatedRowHeight = 44
        tableFaq.tableFooterView = UIView()
        tableFaq.delegate     = self
        tableFaq.dataSource = self
    }

}

extension FaqVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if arrFaq.count > 0 {
            return arrFaq.count
        }else{
             return arrTermsCondition.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellFaq = tableView.dequeueReusableCell(withIdentifier: FaqCell.identifier) as! FaqCell
        if arrFaq.count != 0 {
            let faq = arrFaq[indexPath.row]
            cellFaq.labelQuestion.text = faq.question
            cellFaq.labelAnswer.text   = faq.answer
        }else{
            let term = arrTermsCondition[indexPath.row]
            cellFaq.labelQuestion.text = term.termtitle
            cellFaq.labelAnswer.text  = term.termdescription
        }
        cellFaq.selectionStyle = .none
        return cellFaq
    }
    @IBAction func buttonBack_didpressed(button:UIButton){
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension FaqVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
