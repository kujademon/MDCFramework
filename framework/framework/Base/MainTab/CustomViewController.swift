//
//  CustomViewController.swift
//  framework
//
//  Created by Pitchaorn on 10/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class CustomViewController: BaseTableViewController {

    // MARK: Properties
    
    private let cellReuseIdentifier = "cell"
    
    var exampleList = [
        Example(title: "Radio Button", subTitle: "RadioButtonViewController"),
        Example(title: "Silde Menu", subTitle: "SildeMenuViewController"),
    ]
    
    
    
    override func configureCell(cell: UITableViewCell, indexPath: IndexPath) {
        
    }
    
    
    
    
}

// MARK: - UITableViewDataSource

extension CustomViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exampleList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! BaseTableViewCell
        cell.BaseCell = exampleList[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CustomViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let example = exampleList[indexPath.row]
        pushOrPresentViewController(viewController: example.subTitle, cellIndexPath: indexPath,title: example.title)
    }
    
}
