//
//  BaseTableViewController.swift
//  framework
//
//  Created by Pitchaorn on 3/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    private var detailTargetChange: NSObjectProtocol!
    
    private let cellReuseIdentifier = "cell"
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(BaseTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
         if #available(iOS 11.0, *) {
            
         }else{
            if let tabbar = self.tabBarController{
                let adjustForTabbarInsets: UIEdgeInsets = UIEdgeInsetsMake(0, 0, tabbar.tabBar.frame.height, 0)
                self.tableView.contentInset = adjustForTabbarInsets
                self.tableView.scrollIndicatorInsets = adjustForTabbarInsets
            }
        }
        
       
        
    }

    
    
    // MARK: Utility functions
    
    func configureCell(cell: UITableViewCell, indexPath: IndexPath) {
        // For subclasses to override.
    }
    
    func pushOrPresentViewController(viewController: String, cellIndexPath: IndexPath, title: String) {
        
        if let controller = viewControllerFromString(viewControllerName: viewController) {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            navigationController?.pushViewController(controller, animated: true)
            controller.title = title
        }
        
        
    }

}

// MARK: - UITableViewDelegate

extension BaseTableViewController {
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.accessoryType = .disclosureIndicator
        tableView.deselectRow(at: indexPath, animated: false)
        
        
        configureCell(cell: cell, indexPath: indexPath as IndexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


