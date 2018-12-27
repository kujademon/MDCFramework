//
//  ActivityIndicatorViewController.swift
//  framework
//
//  Created by Pitchaorn on 3/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class ActivityIndicatorViewController: UITableViewController {
    
    private let cellReuseIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }

    //MARK: - Method
    
    func setupTableView(){
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.register(ActivityIndicatorTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.allowsSelection = false

    }
    

    
    
   

}
extension ActivityIndicatorViewController{
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "GRAY"
        }else if section == 1{
            return "TINTED"
        }
        return ""
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ActivityIndicatorTableViewCell
        cell.indexpath = indexPath
        return cell
        
        
    }
}
