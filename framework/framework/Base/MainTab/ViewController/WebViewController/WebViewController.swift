//
//  WebViewController.swift
//  framework
//
//  Created by Pitchaorn on 6/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit
import WebKit

/** NOTE:
 If your app customizes, interacts with, or controls the display of web content, use the WKWebView class.
 If you want to view a website from anywhere on the Internet, use the SFSafariViewController class.
 */

class WebViewController: UIViewController {
    
    // MARK: - Properties
    
    var constraintCollector = [NSLayoutConstraint]()
    
    lazy var webview: WKWebView = {
        
        let webview = WKWebView()
        
        return webview
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
         navigationController?.navigationBar.isTranslucent = false
        webview.navigationDelegate = self // So we can capture failures in "didFailProvisionalNavigation".
        loadAddressURL()
        
    }

    @available(iOS 11.0, *)
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        setupView()
    }
    
    
    fileprivate func setupView(){
        view.removeConstraints(constraintCollector)
        
       
        
        view.addSubview(webview)
        
        view.addConstraints(with: "H:|-left-[v0]-right-|", to: webview, constraintCollector: &constraintCollector)
        view.addConstraints(with: "V:|-top-[v0]-bottom-|", to: webview, constraintCollector: &constraintCollector)
        
        
    }
    
    // MARK: - Loading
    
    func loadAddressURL() {
        // Set the content to local html in our app bundle.
        if let url = Bundle.main.url(forResource: "content", withExtension: "html") {
            webview.loadFileURL(url, allowingReadAccessTo: url)
        }
    }
}

// MARK: - WKNavigationDelegate

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let webKitError = error as NSError
        if webKitError.code == NSURLErrorNotConnectedToInternet {
            // Report the error inside the web view.
            let localizedErrorMessage = NSLocalizedString("An error occured:", comment: "")
            
            let message = "\(localizedErrorMessage) \(error.localizedDescription)"
            let errorHTML =
            "<!doctype html><html><body><font color = 'red'><div style=\"width: 100%%; text-align: center; font-size: 36pt;\">\(message)</div></font></body></html>"
            
            webView.loadHTMLString(errorHTML, baseURL: nil)
        }
    }
    
}

