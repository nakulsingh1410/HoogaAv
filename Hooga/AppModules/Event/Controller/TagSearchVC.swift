//
//  TagSearchVC.swift
//  Hooga
//
//  Created by @mrendra on 31/01/18.
//  Copyright © 2018 Nakul Singh. All rights reserved.
//

import UIKit

protocol TagSearchDelegate {
    func selectedTag(tag:Tags)
}

class TagSearchVC: UIViewController ,UISearchResultsUpdating{
    
    
       var arrTags                      = [Tags]()
       var arrTagsFilter             = [Tags]()
       var delegate : TagSearchDelegate?
    
    @IBOutlet weak var tableTagSearch : UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         configTableViewForTag()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func configTableViewForTag()  {
        arrTagsFilter = arrTags
     tableTagSearch.register(UITableViewCell.self, forCellReuseIdentifier: "cellidSearch")
        
        tableTagSearch.rowHeight = 300
        
        tableTagSearch.estimatedRowHeight = UITableViewAutomaticDimension
        tableTagSearch.tableFooterView = UIView()
        tableTagSearch.delegate     = self
        tableTagSearch.dataSource = self
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableTagSearch.tableHeaderView = searchController.searchBar
        
        tableTagSearch.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.searchBar.text! == "" {
            arrTagsFilter = arrTags
        } else {
            // Filter the results
            arrTagsFilter = arrTags.filter { ($0.tag?.lowercased().contains(searchController.searchBar.text!.lowercased()))! }
         }
        tableTagSearch.reloadData()
        }
    
    @IBAction func buttonCancel_didPressed(btn:UIButton){
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension TagSearchVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTagsFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellSearch = tableView.dequeueReusableCell(withIdentifier: "cellidSearch")
        let tag = arrTagsFilter[indexPath.row]
        cellSearch?.textLabel?.text = tag.tag
        cellSearch?.selectionStyle = .none
        return cellSearch!
    }
}

extension TagSearchVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if delegate != nil {
            
            delegate?.selectedTag(tag: arrTagsFilter[indexPath.row])
            self.dismiss(animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
