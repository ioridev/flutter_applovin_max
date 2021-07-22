import Flutter
import UIKit
import AppLovinSDK

class ALMAXReward:  NSObject, MARewardedAdDelegate {
    public var Ad: MARewardedAd?
    private var retryAttempt = 0.0
   
    func initRewardedApplovin(_ call: FlutterMethodCall) {
       if let args = call.arguments as? Dictionary<String, Any>,
        let unitId = args["UnitId"] as? String {
            Ad = MARewardedAd.shared(withAdUnitIdentifier: unitId)
            Ad?.delegate = self
            Ad?.load()
       }
    }
    
    public func didStartRewardedVideo(for ad: MAAd) {
        globalMethodChannel?.invokeMethod("RewardedVideoStarted", arguments: nil)
    }
    
    public func didCompleteRewardedVideo(for ad: MAAd) {
        globalMethodChannel?.invokeMethod("RewardedVideoCompleted", arguments: nil)
    }
    
    public func didRewardUser(for ad: MAAd, with reward: MAReward) {
        globalMethodChannel?.invokeMethod("UserRewarded", arguments: nil)
    }
    
    public func didLoad(_ ad: MAAd) {
        retryAttempt = 0
        globalMethodChannel?.invokeMethod("AdLoaded", arguments: nil)
    }
    
    public func didDisplay(_ ad: MAAd) {
        globalMethodChannel?.invokeMethod("AdDisplayed", arguments: nil)
    }
    
    public func didHide(_ ad: MAAd) {
        Ad?.load()
        globalMethodChannel?.invokeMethod("AdHidden", arguments: nil)
    }
    
    public func didClick(_ ad: MAAd) {
        globalMethodChannel?.invokeMethod("AdClicked", arguments: nil)
    }
    
    func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {
        retryAttempt += 1
        let delaySec = pow(2.0, min(6.0, retryAttempt))
        DispatchQueue.main.asyncAfter(deadline: .now() + delaySec) {
            self.Ad?.load()
        }
    }
    
    func didFail(toDisplay ad: MAAd, withError error: MAError) {
        globalMethodChannel?.invokeMethod("AdFailedToDisplay", arguments: nil)
    }

    
}
