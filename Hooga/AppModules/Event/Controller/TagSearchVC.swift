//
//  TagSearchVC.swift
//  Hooga
//
//  Created by @mrendra on 31/01/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

class TagSearchVC: UIViewController ,UISearchResultsUpdating{
    
    

    @IBOutlet weak var tableTagSearch : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func configTableViewForEventList()  {
        
        tableTagSearch.register(EventCell.nib, forCellReuseIdentifier: EventCell.identifier)
        
        tableTagSearch.rowHeight = 300
        
        tableTagSearch.estimatedRowHeight = UITableViewAutomaticDimension
        tableTagSearch.tableFooterView = UIView()
        tableTagSearch.delegate     = self
        tableTagSearch.dataSource = self
        
        
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        }
}

extension TagSearchVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension TagSearchVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
