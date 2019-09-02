//
//  Banner.swift
//  busProject
//
//  Created by Pitchaorn on 29/8/2562 BE.
//  Copyright © 2562 Freewillsolutions. All rights reserved.
//

import UIKit
//import GoogleMobileAds
//
//class Banner: GADBannerView {
//    
//    static let size = kGADAdSizeBanner
//    var parent : UIViewController?{
//        didSet{
//            self.rootViewController = parent
//            self.adUnitID = "ca-app-pub-9753035974211078/2466780462"
//            isAutoloadEnabled = true
//            self.delegate = self
//        }
//    }
//    
//    override init(adSize: GADAdSize) {
//        super.init(adSize: adSize)
//        
//        
//        
//    }
//    
//    override init(adSize: GADAdSize, origin: CGPoint) {
//        super.init(adSize: adSize, origin: origin)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//        
//    }
//    
//    
//}
//extension Banner:GADBannerViewDelegate{
//    /// Tells the delegate an ad request loaded an ad.
//    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
//        print("adViewDidReceiveAd")
//        
//        self.alpha = 0
//        UIView.animate(withDuration: 1, animations: {
//            self.alpha = 1
//        })
//    }
//    
//    /// Tells the delegate an ad request failed.
//    func adView(_ bannerView: GADBannerView,
//                didFailToReceiveAdWithError error: GADRequestError) {
//        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
//    }
//    
//    /// Tells the delegate that a full-screen view will be presented in response
//    /// to the user clicking on an ad.
//    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
//        print("adViewWillPresentScreen")
//    }
//    
//    /// Tells the delegate that the full-screen view will be dismissed.
//    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
//        print("adViewWillDismissScreen")
//    }
//    
//    /// Tells the delegate that the full-screen view has been dismissed.
//    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
//        print("adViewDidDismissScreen")
//    }
//    
//    /// Tells the delegate that a user click will open another app (such as
//    /// the App Store), backgrounding the current app.
//    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
//        print("adViewWillLeaveApplication")
//    }
//}


//var bannerView: Banner  = {
//    let view = Banner(adSize: Banner.size)
//    return view
//
//}()
//bannerView.parent = self
