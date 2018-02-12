//
//  OtherPaymentView.swift
//  Hooga
//
//  Created by Nakul Singh on 2/12/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit


protocol OtherPaymentViewDelegate {

    func submitButtonDidTapped(otherPaymentView:OtherPaymentView)
    func cancelButtonDidTapped(otherPaymentView:OtherPaymentView)
}

class OtherPaymentView: UIView {

    @IBOutlet weak var ampountPaid: HoogaTextField!
    @IBOutlet weak var paymentReference: HoogaTextField!
    @IBOutlet weak var otherPayment: HoogaTextField!
    var delegate : OtherPaymentViewDelegate?

    override func awakeFromNib() {
        
    }
    
    func updateDetail(other:SavePaymentDetail)  {
        
        otherPayment.text         = other.otherPayment
        paymentReference.text = other.payrefNumber
        ampountPaid.text          = other.amountPaid
        
    }
    
//    func setPayment(uId:Int) -> Bool {
//        
//        if let value = otherPayment.text,value.trimmingCharacters(in: .whitespaces).isEmpty{
//            Common.showAlert(message: "Please enter other payment")
//            return false
//        }else if let pay = paymentReference.text, pay.trimmingCharacters(in: .whitespaces).isEmpty {
//            Common.showAlert(message: "Please enter  payment reference")
//            return false
//        }else if let paid = ampountPaid.text, paid.trimmingCharacters(in: .whitespaces).isEmpty {
//            Common.showAlert(message: "Please enter paid payment")
//            return false
//        }
//        
//        let payment = SavePaymentDetail()
//        payment.amountPaid = ampountPaid.text
//        payment.otherPayment = otherPayment.text
//        payment.payrefNumber = paymentReference.text
////        payment.ticketid = bookingDetail?.selectedTicketType?.tickettypeid
//        payment.paidOn       = Date().dateString
//        payment.createdOn = Date().dateString
////        otherPayments.append(payment)
//        return true
//    }
    
//    func updateChanges(save:SavePaymentDetail,index:Int)  {
//        save.amountPaid = ampountPaid.text
//        save.otherPayment = otherPayment.text
//        save.payrefNumber = paymentReference.text
//
////        otherPayments[index] = save
//    }
    
 
    
  
     func validate()->(message:String?,isEmpty:Bool){
        
        var message : String?
        if let value = otherPayment.text,value.trimmingCharacters(in: .whitespaces).isEmpty{
            message =  "Please enter other payment"
        }else if let pay = paymentReference.text, pay.trimmingCharacters(in: .whitespaces).isEmpty {
           message =  "Please enter  payment reference"
            
        }else if let paid = ampountPaid.text, paid.trimmingCharacters(in: .whitespaces).isEmpty {
            message =   "Please enter paid payment"
        }

        return (message == nil) ? (message,false):(message,true)
    }
    func clearCurrentDetail()  {
        otherPayment.text = ""
        paymentReference.text = ""
        ampountPaid.text = ""
    }
    
    
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        if validate().isEmpty == true {
            Common.showAlert(message: validate().message!)
            return
        }
        delegate?.submitButtonDidTapped(otherPaymentView: self)
    }
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        //clearCurrentDetail()
        delegate?.cancelButtonDidTapped(otherPaymentView: self)
    }
}
