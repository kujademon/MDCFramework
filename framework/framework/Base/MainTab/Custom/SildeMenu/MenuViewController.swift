//
//  MenuViewController.swift
//  InteractiveSlideoutMenu
//
//  Created by Robert Chen on 2/7/16.
//
//  Copyright (c) 2016 Thorn Technologies LLC
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

class MenuViewController : UIViewController {
    
    // MARK: - Properties
    
    private let cellReuseIdentifier = "cell"
    
    var constraintCollector = [NSLayoutConstraint]()
    
    lazy var dismissButton : UIButton = {
        [unowned self] in
        
        let button = UIButton()
        
        
        return button
        
        }()
    
    lazy var tableView: UITableView = {
        
        [unowned self] in
        
        let table = UITableView(frame: CGRect.zero, style: .plain)
        
        
        table.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        table.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        table.rowHeight = UITableViewAutomaticDimension
        table.estimatedRowHeight = 200
        
        table.delegate = self
        table.dataSource = self
        
        return table
        
        }()
    
    var interactor:Interactor? = nil
    
    var menuActionDelegate:MenuActionDelegate? = nil
    
    let menuItems = ["First", "Second"]
    
    @IBAction func handleGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)

        let progress = MenuHelper.calculateProgress(translation, viewBounds: view.bounds, direction: .right)
        
        MenuHelper.mapGestureStateToInteractor(
            sender.state,
            progress: progress,
            interactor: interactor){
                self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func closeMenu(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    func delay(seconds: Double, completion:@escaping ()->()) {
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            completion()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        dismiss(animated: true){
            self.delay(seconds: 0.5){
                self.menuActionDelegate?.reopenMenu()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissButton.addTarget(self, action: #selector(MenuViewController.closeMenu(_:)), for: .touchUpInside)
       
        
        setupView()
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(MenuViewController.handleGesture))
        dismissButton.addGestureRecognizer(edgePan)
    }
    
    @available(iOS 11.0, *)
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        setupView()
    }
    
    fileprivate func setupView() {
        view.removeConstraints(constraintCollector)
        
        view.backgroundColor = .white
        view.addSubview(dismissButton)
        view.addSubview(tableView)
        
        view.addConstraints(with: "H:|[v0(\(view.frame.width*0.2))][v1]|", to: dismissButton,tableView, constraintCollector: &constraintCollector)
        view.addConstraints(with: "V:|[v0]|", to: dismissButton, constraintCollector: &constraintCollector)
        view.addConstraints(with: "V:|[v0]|", to: tableView, constraintCollector: &constraintCollector)
        
    
    }
    
    
    
}

extension MenuViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        cell.textLabel?.text = menuItems[indexPath.row]
        return cell
    }
}

extension MenuViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let firstViewController = firstVC()
            firstViewController.view.backgroundColor = .red
            menuActionDelegate?.openSegue(firstViewController, sender: nil)
        case 1:
            let secondViewController = secondVC()
            secondViewController.view.backgroundColor = .purple
            menuActionDelegate?.openSegue(secondViewController, sender: nil)
        default:
            break
        }
    }
}
