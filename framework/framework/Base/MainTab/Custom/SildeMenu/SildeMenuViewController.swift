//
//  SildeMenuViewController.swift
//  framework
//
//  Created by Pitchaorn on 28/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

protocol MenuActionDelegate {
    func openSegue(_ vcName: UIViewController, sender: AnyObject?)
    func reopenMenu()
}

class SildeMenuViewController: UIViewController {
    
    let interactor = Interactor()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(SildeMenuViewController.openMenu)), animated: true)
        
    }

    @objc func openMenu(){
        let menuVC = MenuViewController()
        menuVC.transitioningDelegate = self
        menuVC.interactor = interactor
        menuVC.menuActionDelegate = self
        present(menuVC, animated: true, completion: nil)
        
    }

}
extension SildeMenuViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}

extension SildeMenuViewController : MenuActionDelegate {
    func openSegue(_ vcName: UIViewController, sender: AnyObject?) {
        dismiss(animated: true){
            self.navigationController?.pushViewController(vcName, animated: true)
        }
    }
    func reopenMenu(){
        self.openMenu()
    }
}
