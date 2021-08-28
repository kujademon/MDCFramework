//
//  PageControlViewController.swift
//  framework
//
//  Created by Pitchaorn on 5/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class PageControlViewController: UIViewController {
    
    // MARK: Properties
    
    var constraintCollector = [NSLayoutConstraint]()
    
    lazy var pageController: UIPageViewController = {
        [unowned self] in 
        let pageController =  UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        return pageController
        
    }()
    
    
    lazy var pageControl : UIPageControl = {
        [unowned self] in
        let pageControl = UIPageControl()
        
        pageControl.frame = CGRect()
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.numberOfPages = self.pages.count
        
        return pageControl
    }()
    
     var viewName = ""
    
    var pages = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupPage()

        // Do any additional setup after loading the view.
    }

    fileprivate func setupPage(){
        
        view.removeConstraints(constraintCollector)
        pageController.dataSource = self
        pageController.delegate = self
        let initialPage = 0
        let apple = AppleViewController()
        let peach = PeachViewController()
    
        // add the individual viewControllers to the pageViewController
        view.addSubview(pageController.view)
        
        pages.append(apple)
        pages.append(peach)
        pageController.setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
        view.addSubview(pageControl)
        
        pageControl.currentPage = initialPage

        self.view.addConstraints(with: "H:|[v0]|", to: pageControl, constraintCollector: &constraintCollector)
        self.view.addConstraints(with: "V:[v0(20)]-bottom-|", to: pageControl, constraintCollector: &constraintCollector)
    }
    

}

extension PageControlViewController: UIPageViewControllerDelegate{
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        for vc in pendingViewControllers {
            
            if vc.view.accessibilityIdentifier == "AppleVC" {
                
                self.viewName = "Apple"
                
            } else if vc.view.accessibilityIdentifier == "PeachVC" {
                
                self.viewName = "Peach"
                
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        // set the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.firstIndex(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
            }
        }
        
        if completed {
            
            self.navigationItem.title = self.viewName
        }
    }
}

extension PageControlViewController: UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex == 0 {
                // wrap to last page in array
                return self.pages.last
            } else {
                // go to previous page in array
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                // go to next page in array
                return self.pages[viewControllerIndex + 1]
            } else {
                // wrap to first page in array
                return self.pages.first
            }
        }
        return nil
        
    }
    
   
    
    
}
