//
//  SegmentedControlViewController.swift
//  framework
//
//  Created by Pitchaorn on 5/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class SegmentedControlViewController: UITableViewController {
    
    // MARK: - Properties
    
    private let cellReuseIdentifier = "SegmentedTableViewCell"
    
    let titleKey = ["Default","Tinted","Custom Segments","Custom Backgroud"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
    }

    
    //MARK: - Method
    
    fileprivate func setupTableView(){
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.register(SegmentedTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        tableView.allowsSelection = false
        
    }
    
}

extension SegmentedControlViewController{
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! SegmentedTableViewCell
        
        // Configure the cell...
        cell.indexpath = indexPath
        
        cell.delegate = self
        
        return cell
    }
    
}

extension SegmentedControlViewController: SegmentedCellDelegate{
    func selectedSegmentDidChange(_ segmentedControl: UISegmentedControl) {
         print("The selected segment changed for: \(segmentedControl).")
    }
    

}

