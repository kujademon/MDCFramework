//
//  SearchControllerBaseViewController.swift
//  framework
//
//  Created by Pitchaorn on 5/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class SearchControllerBaseViewController: UITableViewController {

    // MARK: - Types
    
    static let tableViewCellIdentifier = "searchResultsCell"
    
    // MARK: - Properties
    
    let allResults = ["Here's", "to", "the", "crazy", "ones.", "The", "misfits.", "The", "rebels.",
                      "The", "troublemakers.", "The", "round", "pegs", "in", "the", "square", "holes.",
                      "The", "ones", "who", "see", "things", "differently.", "They're", "not", "fond", "of",
                      "rules.", "And", "they", "have", "no", "respect", "for", "the", "status", "quo.", "You",
                      "can", "quote", "them,", "disagree", "with", "them,", "glorify", "or", "vilify", "them.",
                      "About", "the", "only", "thing", "you", "can't", "do", "is", "ignore", "them.", "Because",
                      "they", "change", "things.", "They", "push", "the", "human", "race", "forward.", "And",
                      "while", "some", "may", "see", "them", "as", "the", "crazy", "ones,", "we", "see", "genius.",
                      "Because", "the", "people", "who", "are", "crazy", "enough", "to", "think", "they", "can",
                      "change", "the", "world,", "are", "the", "ones", "who", "do."]
    
    lazy var visibleResults: [String] = allResults
    
    /// A `nil` / empty filter string means show all results. Otherwise, show only results containing the filter.
    var filterString: String? = nil {
        didSet {
            if filterString == nil || filterString!.isEmpty {
                visibleResults = allResults
            } else {
                // Filter the results using a predicate based on the filter string.
                let filterPredicate = NSPredicate(format: "self contains[c] %@", argumentArray: [filterString!])
                
                visibleResults = allResults.filter { filterPredicate.evaluate(with: $0) }
            }
            
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: SearchControllerBaseViewController.tableViewCellIdentifier)
    }

}
// MARK: - UITableViewDataSource

extension SearchControllerBaseViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: SearchControllerBaseViewController.tableViewCellIdentifier, for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel!.text = visibleResults[indexPath.row]
    }
    
}
