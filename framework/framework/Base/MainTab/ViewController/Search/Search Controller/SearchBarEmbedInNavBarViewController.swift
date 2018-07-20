//
//  SearchBarEmbedInNavBarViewController.swift
//  framework
//
//  Created by Pitchaorn on 5/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class SearchBarEmbedInNavBarViewController: SearchControllerBaseViewController {

    // MARK: - Properties
    
    // `searchController` is set in viewDidLoad(_:).
    var searchController: UISearchController!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the search results view controller and use it for the `UISearchController`.
        let searchResultsViewController = SearchResultsViewController()
           
            
        // Create the search controller and make it perform the results updating.
        searchController = UISearchController(searchResultsController: searchResultsViewController)
        searchController.searchResultsUpdater = searchResultsViewController
    
        searchController.hidesNavigationBarDuringPresentation = false
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            // Fallback on earlier versions
            searchController.searchBar.isTranslucent = false
            searchController.dimsBackgroundDuringPresentation = false
            searchController.hidesNavigationBarDuringPresentation = false
        }
        
        /** Configure the search controller's search bar. For more information on how to configure
         search bars, see the "Search Bar" group under "Search".
         */
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.placeholder = NSLocalizedString("Search", comment: "")
        
        // Include the search bar within the navigation bar.
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
            navigationItem.titleView = searchController.searchBar
        }
        
        definesPresentationContext = true
    }
}
