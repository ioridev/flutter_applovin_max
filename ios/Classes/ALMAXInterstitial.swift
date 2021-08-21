import Flutter
import UIKit
import AppLovinSDK



class ALMAXInterstitial:  NSObject, MAAdViewAdDelegate {

    public var Ad: MAInterstitialAd?
    private var retryAttempt = 0.0

    func initInterApplovin(_ call: FlutterMethodCall) {
       if let args = call.arguments as? Dictionary<String, Any>,
        let unitId = args["UnitId"] as? String {
            Ad = MAInterstitialAd.init(adUnitIdentifier: unitId)
            Ad?.delegate = self
            //Load first ad
            Ad?.load()
       }
    }
   
    func didLoad(_ ad: MAAd)
    {
        retryAttempt = 0
        globalMethodChannel?.invokeMethod("AdLoaded", arguments: nil)
    }
    
    func didDisplay(_ ad: MAAd) {
        globalMethodChannel?.invokeMethod("AdDisplayed", arguments: nil)
    }
    
    func didClick(_ ad: MAAd) {
        globalMethodChannel?.invokeMethod("AdClicked", arguments: nil)
    }
    
    func didExpand(_ ad: MAAd) {  }
    
    func didCollapse(_ ad: MAAd) { }
    
    func didHide(_ ad: MAAd)
    {
        Ad?.load()
        globalMethodChannel?.invokeMethod("AdHidden", arguments: nil)
    }

    func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {
        retryAttempt += 1
        let delaySec = pow(2.0, min(6.0, retryAttempt))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delaySec) {
            self.Ad?.load()
        }
    }
    
    func didFail(toDisplay ad: MAAd, withError error: MAError) {
        Ad?.load()
    }
}
