//
//  ToolbarViewControllers.swift
//  framework
//
//  Created by Pitchaorn on 6/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class ToolbarViewControllers: BaseTableViewController {
    
    // MARK: Properties
    
    private let cellReuseIdentifier = "cell"
    
    var exampleList = [
        Example(title: "Default", subTitle: "DefaultToolbarViewController"),
        Example(title: "Tinted", subTitle: "TintedToolbarViewController"),
        Example(title: "Custom", subTitle: "CustomToolbarViewController")
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
    }

    

}
// MARK: - UITableViewDataSource

extension ToolbarViewControllers {
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

extension ToolbarViewControllers {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let example = exampleList[indexPath.row]
        pushOrPresentViewController(viewController: example.subTitle, cellIndexPath: indexPath,title: example.title)
    }
    
}
