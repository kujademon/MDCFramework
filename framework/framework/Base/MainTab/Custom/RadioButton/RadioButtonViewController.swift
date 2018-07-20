//
//  RadioButtonViewController.swift
//  framework
//
//  Created by Pitchaorn on 11/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class RadioButtonViewController: BaseTableViewController {

    // MARK: Properties
    
    private let cellReuseIdentifier = "cell"
    
    var exampleList = [
        Example(title: "Selected", subTitle: "RadioButtonSelectedController"),
        Example(title: "Multi Selected", subTitle: "RadioButtonMultiController")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
    }
    
}
// MARK: - UITableViewDataSource

extension RadioButtonViewController {
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

extension RadioButtonViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let example = exampleList[indexPath.row]
        pushOrPresentViewController(viewController: example.subTitle, cellIndexPath: indexPath,title: example.title)
    }
    
}
