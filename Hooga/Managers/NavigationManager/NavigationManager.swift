//
//  NavigationManager.swift
//  Hooga
//
//  Created by Nakul Singh on 1/28/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

enum StoryboardName:String {
    case Main = "Main"
    case LeftSideMenu = "LeftSideMenu"
    case EventListing = "EventListing"
    case EventDetail = "EventDetail"
    case EventRegistration = "EventRegistration"
    case TicketBooking = "TicketBooking"
    case Payment = "Payment"
    case LuckyDraw = "LuckyDraw"
    case QRCode = "QRCode"
    case SlideMenu = "SlideMenu"

}


class NavigationManager {
    
    class func navigateToLogin(navigationController:UINavigationController?) {
        
        let storyboard = UIStoryboard(name: StoryboardName.Main.rawValue, bundle:  Bundle(for: LoginViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController{
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    
    class func navigateToEvent(navigationController:UINavigationController?){
        NavigationManager.setUpSlideMenu()
//        let storyboard = UIStoryboard(name: "EventListing", bundle:  Bundle(for: LoginViewController.self) )
//        if let vcObj = storyboard.instantiateViewController(withIdentifier: "EventListViewController") as? EventListViewController{
//            navigationController?.pushViewController(vcObj, animated: true)
//        }
    }
    
    class func navigateToMyEvent(navigationController:UINavigationController?,screenShown:ComingFromScreen){
        let storyboard = UIStoryboard(name: StoryboardName.LeftSideMenu.rawValue, bundle:  Bundle(for: MyEventViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "MyEventViewController") as? MyEventViewController{
            vcObj.screenShown = screenShown
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    class func navigateToLongDescription(navigationController:UINavigationController?,longDescription:String){
        let storyboard = UIStoryboard(name: StoryboardName.EventDetail.rawValue, bundle:  Bundle(for: MyEventViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "LongDescriptionViewController") as? LongDescriptionViewController{
            vcObj.longDescription = longDescription
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    
    
    
    
    class func userRegistration(navigationController:UINavigationController?,screenShown:RequestForScreen){
        let storyboard = UIStoryboard(name: StoryboardName.Main.rawValue, bundle:  Bundle(for: LoginViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController{
            vcObj.requestingScreen = screenShown
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    
    class func myProfile(screenShown:RequestForScreen){
        let storyboard = UIStoryboard(name: StoryboardName.Main.rawValue, bundle:  Bundle(for: LoginViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController{
            vcObj.requestingScreen = screenShown
            let nvc: UINavigationController = UINavigationController(rootViewController: vcObj)
            UINavigationBar.appearance().tintColor = UIColor.white
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
            UINavigationBar.appearance().barTintColor = kBlueColor
            nvc.navigationBar.isHidden = true
            
        }
    }
    
 
    
    class func forgotPassword(navigationController:UINavigationController?){
        let storyboard = UIStoryboard(name: StoryboardName.Main.rawValue, bundle:  Bundle(for: LoginViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? ForgotPasswordViewController{
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    
    
    class func navigateToOTP(navigationController:UINavigationController?,screenComingFrom:ComingFromScreen){
        let storyboard = UIStoryboard(name: StoryboardName.Main.rawValue, bundle:  Bundle(for: LoginViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "RequestOTPViewController") as? RequestOTPViewController{
            vcObj.screenFlow = screenComingFrom
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    
    class func navigateToSetPassword(navigationController:UINavigationController?,screenFlow:ComingFromScreen){
        let storyboard = UIStoryboard(name: StoryboardName.Main.rawValue, bundle:  Bundle(for: RequestOTPViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "SetPasswordViewController") as? SetPasswordViewController{
            vcObj.screenFlow = screenFlow
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    
    class func navigateToEventDetail(navigationController:UINavigationController? , evntId : Int,comingFrom:ComingFromScreen){
        let storyboard = UIStoryboard(name: StoryboardName.EventDetail.rawValue, bundle:  Bundle(for: EventDetailVC.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "EventDetail") as? EventDetailVC{
            vcObj.eventID = evntId
            vcObj.comingFrom = comingFrom
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    class func eventRegistration(navigationController:UINavigationController? , evntDetail : EventDetail){
        let storyboard = UIStoryboard(name: StoryboardName.EventRegistration.rawValue, bundle:  Bundle(for: EventRegisterationViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "EventRegisterationViewController") as? EventRegisterationViewController{
            vcObj.eventDetail = evntDetail
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    
    class func ticketBooking(navigationController:UINavigationController? , evntDetail : EventDetail,comingFrom:ComingFromScreen){
        let storyboard = UIStoryboard(name: StoryboardName.TicketBooking.rawValue, bundle:  Bundle(for: TicketBookingViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "TicketBookingViewController") as? TicketBookingViewController{
            vcObj.eventDetail = evntDetail
            vcObj.comingFrom = comingFrom
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    
    class func bookingDetail(navigationController:UINavigationController? , evntDetail : EventRecord,comingFrom:ComingFromScreen){
        let storyboard = UIStoryboard(name: StoryboardName.TicketBooking.rawValue, bundle:  Bundle(for: BookingDetailVC.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "BookingDetailVC") as? BookingDetailVC{
            vcObj.eventRecord = evntDetail
            vcObj.comingFrom = comingFrom
           navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    class func navigateToAddParticipate(navigationController:UINavigationController? , evntDetail : EventDetail,comingFrom:ComingFromScreen){
        let storyboard = UIStoryboard(name: StoryboardName.TicketBooking.rawValue, bundle:  Bundle(for: AddParticipateViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "AddParticipateViewController") as? AddParticipateViewController{
            vcObj.eventDetail = evntDetail
            vcObj.comingFrom = comingFrom
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    
    class func paymentDetail(navigationController:UINavigationController? , evntDetail : EventRecord){
        let storyboard = UIStoryboard(name: StoryboardName.Payment.rawValue, bundle:  Bundle(for: BookingDetailVC.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "PaymentVC") as? PaymentVC{
            //vcObj.eventRecord = evntDetail
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    
    
    class func otherPaymentDetail(navigationController:UINavigationController? , evntDetail : EventRecord,savedTicketDetail:[BookingDetailResponse]){
        let storyboard = UIStoryboard(name: StoryboardName.Payment.rawValue, bundle:  Bundle(for: BookingDetailVC.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "OtherPaymentMode") as? OtherPaymentMode{
            vcObj.bookingDetail = evntDetail
            vcObj.savedTicketDetail = savedTicketDetail
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    
    class func thanksController(navigationController:UINavigationController? , evntDetail : EventRecord){
        let storyboard = UIStoryboard(name: StoryboardName.Payment.rawValue, bundle:  Bundle(for: BookingDetailVC.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "ThanksVC") as? ThanksVC{
            //vcObj.bookingDetail = evntDetail
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    
    class func luckyDraw(navigationController:UINavigationController? , evntDetail : EventDetail){
        let storyboard = UIStoryboard(name: StoryboardName.LuckyDraw.rawValue, bundle:  Bundle(for: LuckyDrawVC.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "LuckyDrawVC") as? LuckyDrawVC{
            vcObj.eventDetail = evntDetail
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    
    
    
    class func openParticipate(navigationController:UINavigationController? , evntDetail : EventDetail){
        let storyboard = UIStoryboard(name: StoryboardName.LuckyDraw.rawValue, bundle:  Bundle(for: ParticipateViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "ParticipateViewController") as? ParticipateViewController{
            vcObj.eventDetail = evntDetail
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    class func openResultParticipate(navigationController:UINavigationController? , evntDetail : EventDetail){
        let storyboard = UIStoryboard(name: StoryboardName.LuckyDraw.rawValue, bundle:  Bundle(for: ParticipantResultViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "ParticipantResultViewController") as? ParticipantResultViewController{
            vcObj.eventDetail = evntDetail
            navigationController?.pushViewController(vcObj, animated: true)
            
        }
    }
    class func QRCode(navigationController:UINavigationController? , evntDetail : EventDetail){
        let storyboard = UIStoryboard(name: StoryboardName.QRCode.rawValue, bundle:  Bundle(for: QcodeTicketVC.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "QcodeTicketVC") as? QcodeTicketVC{
            vcObj.eventDetail = evntDetail
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    
    class func participateDetail(navigationController:UINavigationController? , participateDetail: ShowMyEventLuckyDrawResult,eventDetail:EventDetail){
        let storyboard = UIStoryboard(name: StoryboardName.LuckyDraw.rawValue, bundle:  Bundle(for: ParticipateDetailViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "ParticipateDetailViewController") as? ParticipateDetailViewController{
            vcObj.participateDetail = participateDetail
            vcObj.eventDetail = eventDetail
            navigationController?.pushViewController(vcObj, animated: true)
        }
    }
    
    
    
    
    class func logout(){
        let storyboard = UIStoryboard(name: StoryboardName.Main.rawValue, bundle:  Bundle(for: LoginViewController.self) )
        if let vcObj = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController{
            let nvc: UINavigationController = UINavigationController(rootViewController: vcObj)
            UINavigationBar.appearance().tintColor = UIColor.white
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
            UINavigationBar.appearance().barTintColor = kBlueColor
            nvc.navigationBar.isHidden = true
            vcObj.modalTransitionStyle = .crossDissolve
            vcObj.modalPresentationStyle = .custom
            appDelegate.window?.rootViewController = nvc
            appDelegate.window?.makeKeyAndVisible()
            StorageModel.removeUserData()
        }
    }
    
    
    
     class func setUpSlideMenu()  {
        let storyboard = UIStoryboard(name: StoryboardName.EventListing.rawValue, bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "EventListViewController") as! EventListViewController
        
        let sideMenuStorybard =  UIStoryboard(name: StoryboardName.SlideMenu.rawValue, bundle: nil)
        let leftViewController = sideMenuStorybard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
        let rightViewController = sideMenuStorybard.instantiateViewController(withIdentifier: "RightViewController") as! RightViewController
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        UINavigationBar.appearance().barTintColor = kBlueColor
        nvc.navigationBar.isHidden = true
        
        
        leftViewController.mainViewController = nvc
        
        let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)
//        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        //        slideMenuController.delegate = mainViewController
        appDelegate.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        appDelegate.window?.rootViewController = slideMenuController
        appDelegate.window?.makeKeyAndVisible()
    }
    
}
