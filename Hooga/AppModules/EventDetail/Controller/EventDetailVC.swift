//
//  EventDetailVC.swift
//  Hooga
//
//  Created by @mrendra on 28/01/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class EventDetailVC: UIViewController {

    @IBOutlet var tableDetail : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func configTableview()  {
        
        tableDetail.register(BannerCell.nib, forCellReuseIdentifier: BannerCell.identifier)
        
        tableDetail.register(EventTitleCell.nib, forCellReuseIdentifier: EventTitleCell.identifier)
        
         tableDetail.register(ContactCell.nib, forCellReuseIdentifier: ContactCell.identifier)
        
        
        tableDetail.register(GalleryCell.nib, forCellReuseIdentifier: GalleryCell.identifier)
        
        tableDetail.register(ShareCell.nib, forCellReuseIdentifier: ShareCell.identifier)
        
        tableDetail.separatorStyle = .none
        
        tableDetail.rowHeight = 300
        
        tableDetail.estimatedRowHeight = UITableViewAutomaticDimension
        tableDetail.tableFooterView = UIView()
        tableDetail.delegate     = self
        tableDetail.dataSource = self
        
    }
}

extension EventDetailVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        return cell
    }
    
}

extension EventDetailVC : UITableViewDelegate{
    
    
    
}
