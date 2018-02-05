//
//  PaymentVC.swift
//  Hooga
//
//  Created by @mrendra on 03/02/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class PaymentVC: UIViewController {

    
    @IBOutlet weak var month: HoogaTextField!
    
    @IBOutlet weak var referenceNo: HoogaTextField!
    @IBOutlet weak var others: UIView!
    @IBOutlet weak var cvv: HoogaTextField!
    @IBOutlet weak var year: HoogaTextField!
    
    @IBOutlet weak var creditCard: HoogaTextField!
    @IBOutlet weak var lastName: HoogaTextField!
    @IBOutlet weak var firstName: HoogaTextField!
    @IBOutlet weak var collectionCreditCard: UICollectionView!
    @IBOutlet weak var navHeaderView : CustomNavHeaderView!
   
    var indexLast : IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configoreNavigationHeader()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configoreNavigationHeader()  {
        navHeaderView.viewController = self
        navHeaderView.navBarTitle = "Payment"
        navHeaderView.backButtonType = .Back
    }

    @IBAction func buttonProceedPayment_didPressed(_ sender: Any) {
    }
    
    @IBAction func buttonCancel_didPressed(_ sender: Any) {
    }
}

extension PaymentVC : UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellCard = collectionView.dequeueReusableCell(withReuseIdentifier: "CreditCardCell", for: indexPath) as! CreditCardCell
        
        if indexLast != nil {
            
            if indexLast == indexPath{
                
            }else{
                
            }
        }else{
            
        }
        
        return cellCard
    }

}

extension PaymentVC : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexLast = indexPath
        collectionView.reloadData()
    }
}
