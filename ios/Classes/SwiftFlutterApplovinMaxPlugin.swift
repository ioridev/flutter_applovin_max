import AppLovinSDK
import Flutter
import UIKit

var globalMethodChannel: FlutterMethodChannel?

public class SwiftFlutterApplovinMaxPlugin: NSObject, FlutterPlugin {
  private var rewardMax = ALMAXReward()
  private var interMax = ALMAXInterstitial()

  public static func register(with registrar: FlutterPluginRegistrar) {
    globalMethodChannel = FlutterMethodChannel(
      name: "flutter_applovin_max", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterApplovinMaxPlugin()
    registrar.addMethodCallDelegate(instance, channel: globalMethodChannel!)
    ALSdk.shared()!.mediationProvider = ALMediationProviderMAX
    ALSdk.shared()!.initializeSdk(completionHandler: { configuration in
      // AppLovin SDK is initialized, start loading ads now or later if ad gate is reached
    })
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "SetUser":
      if let args = call.arguments as? [String: Any],
        let userId = args["UserId"] as? String
      {
        ALSdk.shared()!.userIdentifier = userId
      }
    case "SetPrivaxy":
      if let args = call.arguments as? [Bool: Any],
        let hasConsent = args["HasConsent"] as? Bool,
        let isAgeRestricted = args["IsAgeRestricted"] as? Bool,
        let doNotSell = args["DoNotSell"] as? Bool
      {
        ALPrivacySettings.setIsAgeRestrictedUser(isAgeRestricted)
        ALPrivacySettings.setHasUserConsent(hasConsent)
        ALPrivacySettings.setDoNotSell(doNotSell)
      }
    /*Reward*/
    case "InitRewardAd":
      rewardMax.initRewardedApplovin(call)
      result(true)
    case "ShowRewardVideo":
      if rewardMax.Ad?.isReady ?? false {
        rewardMax.Ad?.show()
        result(true)
      }
    case "IsRewardLoaded":
      result(rewardMax.Ad?.isReady ?? false)
    /*Inter*/
    case "InitInterAd":
      interMax.initInterApplovin(call)
      result(true)
    case "ShowInterVideo":
      if interMax.Ad?.isReady ?? false {
        interMax.Ad?.show()
        result(true)
      }
    case "IsInterLoaded":
      result(interMax.Ad?.isReady ?? false)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
