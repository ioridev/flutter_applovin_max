import Flutter
import UIKit
import AppLovinSDK

var globalMethodChannel: FlutterMethodChannel?

public class SwiftFlutterApplovinMaxPlugin:  NSObject, FlutterPlugin {
    private var rewardMax = ALMAXReward();
    private var interMax = ALMAXInterstitial();

    public static func register(with registrar: FlutterPluginRegistrar) {
        globalMethodChannel = FlutterMethodChannel(name: "flutter_applovin_max", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterApplovinMaxPlugin()
        registrar.addMethodCallDelegate(instance, channel: globalMethodChannel!)
        ALSdk.shared()!.mediationProvider = ALMediationProviderMAX
        ALSdk.shared()!.initializeSdk(completionHandler: { configuration in
            // AppLovin SDK is initialized, start loading ads now or later if ad gate is reached
        })
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
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
