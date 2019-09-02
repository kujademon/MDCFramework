//
//  FacebookLoginManager.swift
//  busProject
//
//  Created by Pitchaorn on 15/8/2562 BE.
//  Copyright © 2562 Freewillsolutions. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit

class FacebookSignInManager: NSObject {
    
    typealias LoginCompletionBlock = (Dictionary<String, AnyObject>?, NSError?) -> Void
    
    //MARK:- Public functions
    class func basicInfoWithCompletionHandler(_ fromViewController:AnyObject, onCompletion: @escaping LoginCompletionBlock) -> Void {
        
        //Check internet connection if no internet connection then return
        
        
        self.getBaicInfoWithCompletionHandler(fromViewController) { (dataDictionary:Dictionary<String, AnyObject>?, error: NSError?) -> Void in
            onCompletion(dataDictionary, error)
        }
    }
    
    class func logoutFromFacebook() {
        if AccessToken.current != nil{
            LoginManager().logOut()
            checkToken()
        }
    }
    
    class func checkToken(){
        if AccessToken.current == nil{
            Config().setRootView(LoginViewController.self,.Main)
        }
    }
    
    class func token() -> AccessToken? {
        return AccessToken.current
    }
    
    //MARK:- Private functions
    class fileprivate func getBaicInfoWithCompletionHandler(_ fromViewController:AnyObject, onCompletion: @escaping LoginCompletionBlock) -> Void {
        let permissionDictionary = [
            "fields" : "id,name,first_name,last_name,gender,email,birthday,picture.type(large)",
            //"locale" : "en_US"
        ]
        if AccessToken.current != nil {
            GraphRequest(graphPath: "/me", parameters: permissionDictionary)
                .start(completionHandler:  { (connection, result, error) in
                    if error == nil {
                        onCompletion(result as? Dictionary<String, AnyObject>, nil)
                    } else {
                        onCompletion(nil, error as NSError?)
                    }
                })
            
        } else {
            LoginManager().logIn(permissions: ["email", "public_profile", "user_photos"], from: fromViewController as? UIViewController, handler: { (result, error) -> Void in
                if error != nil {
                    LoginManager().logOut()
                    if let error = error as NSError? {
                        let errorDetails = [NSLocalizedDescriptionKey : "Processing Error. Please try again!"]
                        let customError = NSError(domain: "Error!", code: error.code, userInfo: errorDetails)
                        onCompletion(nil, customError)
                    } else {
                        onCompletion(nil, error as NSError?)
                    }
                    
                } else if (result?.isCancelled)! {
                    LoginManager().logOut()
                    let errorDetails = [NSLocalizedDescriptionKey : "Request cancelled!"]
                    let customError = NSError(domain: "Request cancelled!", code: 1001, userInfo: errorDetails)
                    onCompletion(nil, customError)
                } else {
                    let pictureRequest = GraphRequest(graphPath: "me", parameters: permissionDictionary)
                    let _ = pictureRequest.start(completionHandler: {
                        (connection, result, error) -> Void in
                        
                        if error == nil {
                            onCompletion(result as? Dictionary<String, AnyObject>, nil)
                        } else {
                            onCompletion(nil, error as NSError?)
                        }
                    })
                }
            })
        }
    }
}
