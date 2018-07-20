//
//  DefaultViewController.swift
//  framework
//
//  Created by Pitchaorn on 30/4/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class DefaultViewController: BaseTableViewController {
    
    // MARK: Properties
    
    private let cellReuseIdentifier = "cell"
    
    var exampleList = [
        Example(title: "Activity Indicators", subTitle: "ActivityIndicatorViewController"),
        Example(title: "Alert Controller", subTitle: "AlertControllerViewController"),
        Example(title: "Buttons", subTitle: "ButtonViewController"),
        Example(title: "Collection Views", subTitle: "CollectionViewController"),
        Example(title: "Date Picker", subTitle: "DatePickerController"),
        Example(title: "Image View", subTitle: "ImageViewController"),
        Example(title: "Page Control", subTitle: "PageControlViewController"),
        Example(title: "Picker View", subTitle: "PickerViewController"),
        Example(title: "Progress Views", subTitle: "ProgressViewController"),
        Example(title: "Search", subTitle: "SearchViewControllers"),
        Example(title: "Segmented Controls", subTitle: "SegmentedControlViewController"),
        Example(title: "Sliders", subTitle: "SliderViewController"),
        Example(title: "Stack Views", subTitle: "StackViewController"),
        Example(title: "Steppers", subTitle: "StepperViewController"),
        Example(title: "Switches", subTitle: "SwitchViewController"),
        Example(title: "Tabbar Controller", subTitle: "TabbarController"),
        Example(title: "Text Fields", subTitle: "TextFieldViewController"),
        Example(title: "Text View", subTitle: "TextViewController"),
        Example(title: "Toolbars", subTitle: "ToolbarViewControllers"),
        Example(title: "Web View", subTitle: "WebViewController")
    ]
    
    
    
    override func configureCell(cell: UITableViewCell, indexPath: IndexPath) {
        
    }

   
    

}

// MARK: - UITableViewDataSource

extension DefaultViewController {
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

extension DefaultViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let example = exampleList[indexPath.row]
        pushOrPresentViewController(viewController: example.subTitle, cellIndexPath: indexPath,title: example.title)
    }
    
}
