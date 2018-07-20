//
//  SearchViewControllers.swift
//  framework
//
//  Created by Pitchaorn on 5/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class SearchViewControllers: BaseTableViewController {
    
    // MARK: Properties
    
    private let cellReuseIdentifier = "cell"
    
    var exampleList = [
        Example(title: "Default", subTitle: "DefaultSearchBarViewController"),
        Example(title: "Custom", subTitle: "CustomSearchBarViewController"),
        Example(title: "Search Bar Embedded in Navigation Bar", subTitle: "SearchBarEmbedInNavBarViewController"),
    ]
    let key = ["Search Bars","Search Controller"]
    var list  = [String:[Example]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        mapping()
        
        
    }


    fileprivate func mapping() {
        for (n,item) in exampleList.enumerated(){
            if n <= 1{
                if var bar = list[key[0]]{
                    bar.append(item)
                    list[key[0]] = bar
                }else{
                    list.updateValue([item], forKey: key[0])
                }
                
            }else{
                list.updateValue([item], forKey: key[1])
            }
            
        }
    }
    
    
}
extension SearchViewControllers{
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let section =  indexPath.section
        let row = indexPath.row
        let keyValue = key[section]
        let value = list[keyValue]
        let title = value![row].title
        let subTitle = value![row].subTitle
        let viewControllerName = subTitle
        
        
        
        pushOrPresentViewController(viewController: viewControllerName, cellIndexPath: indexPath, title: title)
    }
    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return key.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = self.key[section]
        if let listCount = list[key]?.count{
            return listCount
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! BaseTableViewCell
        
        let section =  indexPath.section
        let row = indexPath.row
        let keyValue = key[section]
        let value = list[keyValue]
        
        cell.BaseCell = value?[row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return key[section]
    }
}
