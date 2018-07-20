//
//  StepperViewController.swift
//  framework
//
//  Created by Pitchaorn on 6/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class StepperViewController: UITableViewController {
    
    // MARK: - Properties
    
    private let cellReuseIdentifier = "StepperTableViewCell"
    
    let titleKey = ["Default","Tinted","Custom"]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        
    }

    //MARK: - Method
    
    fileprivate func setupTableView(){
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.register(StepperTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        tableView.allowsSelection = false
        
    }

}
extension StepperViewController{
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return titleKey.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleKey[section]
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! StepperTableViewCell
        
        // Configure the cell...
        cell.indexpath = indexPath

        
        return cell
    }
    
}
