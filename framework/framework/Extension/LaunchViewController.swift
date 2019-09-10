//
//  LaunchViewController.swift
//  busProject
//
//  Created by Pitchaorn on 27/8/2562 BE.
//  Copyright © 2562 Freewillsolutions. All rights reserved.
//

import UIKit
//import GoogleSignIn //pod
//import LineSDK //pod

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        view = Launch(frame: self.view.frame)

        // Do any additional setup after loading the view.
        autoLogin()
    }
    
    
    

    func autoLogin(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
//            if GIDSignIn.sharedInstance().hasAuthInKeychain() {
//                // User was previously authenticated to Google. Attempt to sign in.
//                GIDSignIn.sharedInstance().signInSilently()
//            }else if let _ = FacebookSignInManager.token(){
//                self.faceLogin()
//            }else if let _ = AccessTokenStore.shared.current {
//                LoginManager.shared.login(permissions: [.profile], in: self) {
//                    result in
//                    switch result {
//                    case .success(let loginResult):
//                        print(loginResult.accessToken.value)
//                        Config.sharedInstance.social = .line
//                    // Do other things you need with the login result
//                    case .failure(let error):
//                        print(error)
//                    }
//                }
//
//            }else {
//                // User was not previously authenticated to Google.
//                Config.sharedInstance.social = .none
//                //            setupViewNew()
//               Config().setRootView(LoginViewController.self, .Main)
//            }
        }
    }
    
    @objc func faceLogin() {
        
//        FacebookSignInManager.basicInfoWithCompletionHandler(self) { (dataDictionary:Dictionary<String, AnyObject>?, error:NSError?) -> Void in
//            do {
//                guard let data = dataDictionary else {return}
//                let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
//                
//                let decoder = JSONDecoder()
//                let decodedDict = try decoder.decode(FacebookModel.self, from: jsonData) // Generic parameter 'T' could not be inferred
//                
//                print(decodedDict)
//                Config.sharedInstance.social = .facebook
//                AppGlobalManager.sharedInstance.param = RegisParameter( profileFirstname: decodedDict.firstName!, profileLastname: decodedDict.lastName!, profileMobile: "", rolesID: "", tokenType: "facebook", imagesUrl: decodedDict.picture?.data?.url ?? "", userId: decodedDict.id!)
//                CheckID.checkID(decodedDict.id!)
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
