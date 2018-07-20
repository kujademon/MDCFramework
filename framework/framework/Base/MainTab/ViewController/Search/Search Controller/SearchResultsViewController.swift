//
//  SearchResultsViewController.swift
//  framework
//
//  Created by Pitchaorn on 5/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class SearchResultsViewController: SearchControllerBaseViewController {

    // MARK: - Types
    
    /** The identifier string that corresponds to the `SearchResultsViewController`'s
     view controller defined in the main storyboard.
     */
    static let identifier = "SearchResultsViewController"

}

// MARK: - UISearchResultsUpdating

extension SearchResultsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        /**    `updateSearchResultsForSearchController(_:)` is called when the controller is being
         dismissed to allow those who are using the controller they are search as the results
         controller a chance to reset their state. No need to update anything if we're being dismissed.
         */
        guard searchController.isActive else { return }
        
        filterString = searchController.searchBar.text
    }
    
}
