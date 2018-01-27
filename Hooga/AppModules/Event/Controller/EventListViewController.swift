//
//  EventListViewController.swift
//  Hooga
//
//  Created by Nakul Singh on 1/18/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController {
    
    var arrCategories    = [CategoryModel]()
    var arrEntryType    = [EntryTypes]()
    var arrTags         = [Tags]()
    var arrEvents       = [Events]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getCategoryList()
        getEntryTypeList()
        getTagList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}


/*********************************************************************************/
// MARK: APIs
/*********************************************************************************/
extension EventListViewController{
    
    func getCategoryList()  {
        EventService.getCategories() {[weak self]  (flag, categories) in
            guard let weakSelf = self else {return}
            if let array = categories {
                weakSelf.arrCategories = array
                if let categoryId = array.first?.categoryid{
                    weakSelf.getEventList(catId: categoryId, entryType: "", tag: "")
                }
            }else{
                //Common.showAlert(message: message)
            }
        }
    }
    func getEntryTypeList()  {
        EventService.getEntryTypes() {[weak self]  (flag, entryTypes) in
            guard let weakSelf = self else {return}
            if let array = entryTypes {
                weakSelf.arrEntryType = array
            }else{
                //Common.showAlert(message: message)
            }
        }
    }
    
    func getTagList()  {
        EventService.getFillTagsList() {[weak self]  (flag, tags) in
            guard let weakSelf = self else {return}
            if let array = tags {
                weakSelf.arrTags = array
            }else{
                //Common.showAlert(message: message)
            }
        }
    }
    
    func getEventList(catId:Int,entryType:String,tag:String)  {
        EventService.getEventList(categoryid: catId, entrytype: entryType, tag: tag, callback: {[weak self] (flag, events) in
            guard let weakSelf = self else {return}
            if let array = events {
                weakSelf.arrEvents = array
            }else{
                //Common.showAlert(message: message)
            }
        })
    }
    
    
}
