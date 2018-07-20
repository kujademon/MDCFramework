//
//  DefaultSearchBarViewController.swift
//  framework
//
//  Created by Pitchaorn on 5/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class DefaultSearchBarViewController: UIViewController {
    
    // MARK: Properties
    
    var constraintCollector = [NSLayoutConstraint]()
    
    lazy var searchBar: UISearchBar = {
       [unowned self] in
        
        let searchBar = UISearchBar()
        
        searchBar.showsCancelButton = true
        searchBar.showsScopeBar = true
        
        searchBar.scopeButtonTitles = [
            NSLocalizedString("Scope One", comment: ""),
            NSLocalizedString("Scope Two", comment: "")
        ]
        
        searchBar.placeholder = "Search"
        
        return searchBar
        
        
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

        
    }

    fileprivate func setupView() {
        view.backgroundColor = .white
        searchBar.delegate = self
        
        view.addSubview(searchBar)
        view.addConstraints(with: "H:|-left-[v0]-right-|", to: searchBar, constraintCollector: &constraintCollector)
        view.addConstraints(with: "V:|-top-[v0]", to: searchBar, constraintCollector: &constraintCollector)
    }
    
    

}
extension DefaultSearchBarViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print("The default search selected scope button index changed to \(selectedScope).")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("The default search bar keyboard search button was tapped: \(String(describing: searchBar.text)).")
        
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("The default search bar cancel button was tapped.")
        
        searchBar.resignFirstResponder()
    }
    
}
