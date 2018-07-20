//
//  CustomSearchBarViewController.swift
//  framework
//
//  Created by Pitchaorn on 5/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class CustomSearchBarViewController: UIViewController {
    
    // MARK: Properties
    
    var constraintCollector = [NSLayoutConstraint]()
    
    lazy var searchBar: UISearchBar = {
        [unowned self] in
        
        let searchBar = UISearchBar()
        
        searchBar.placeholder = "Search"
        
        return searchBar
        
        
        }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBar()
        setupView()
    }

    
    fileprivate func setupSearchBar() {
        // Do any additional setup after loading the view.
        searchBar.showsCancelButton = true
        searchBar.showsBookmarkButton = true
        
       
        searchBar.tintColor = UIColor.tintPurple()
        
        
        searchBar.backgroundImage = UIImage(named: "search_bar_background")
        
        // Set the bookmark image for both normal and highlighted states.
        let bookmarkImage = #imageLiteral(resourceName: "bookmark_icon")
        searchBar.setImage(bookmarkImage, for: .bookmark, state: .normal)
        
        let bookmarkHighlightedImage = #imageLiteral(resourceName: "bookmark_icon_highlighted")
        searchBar.setImage(bookmarkHighlightedImage, for: .bookmark, state: .highlighted)
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .white
        searchBar.delegate = self
        
        view.addSubview(searchBar)
        view.addConstraints(with: "H:|-left-[v0]-right-|", to: searchBar, constraintCollector: &constraintCollector)
        view.addConstraints(with: "V:|-top-[v0]", to: searchBar, constraintCollector: &constraintCollector)
    }
}
// MARK: - UISearchBarDelegate

extension CustomSearchBarViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("The custom search bar keyboard \"Search\" button was tapped.")
        
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("The custom search bar \"Cancel\" button was tapped.")
        
        searchBar.resignFirstResponder()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("The custom \"bookmark button\" inside the search bar was tapped.")
    }
    
}
