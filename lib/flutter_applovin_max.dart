library applovin;

import 'dart:async';

import 'package:flutter/services.dart';

enum AppLovinAdListener {
  adLoaded,
  adLoadFailed,
  adDisplayed,
  adHidden,
  adClicked,
  onAdDisplayFailed,
  onRewardedVideoStarted,
  onRewardedVideoCompleted,
  onUserRewarded
}

typedef AppLovinListener = Function(AppLovinAdListener? listener);

class FlutterApplovinMax {
  FlutterApplovinMax._();

  static const MethodChannel _channel = MethodChannel('flutter_applovin_max');
  static final Map<String, AppLovinAdListener> appLovinAdListener =
      <String, AppLovinAdListener>{
    'AdLoaded': AppLovinAdListener.adLoaded,
    'AdLoadFailed': AppLovinAdListener.adLoadFailed,
    'AdDisplayed': AppLovinAdListener.adDisplayed,
    'AdHidden': AppLovinAdListener.adHidden,
    'AdClicked': AppLovinAdListener.adClicked,
    'AdFailedToDisplay': AppLovinAdListener.onAdDisplayFailed,
    'RewardedVideoStarted': AppLovinAdListener.onRewardedVideoStarted,
    'RewardedVideoCompleted': AppLovinAdListener.onRewardedVideoCompleted,
    'UserRewarded': AppLovinAdListener.onUserRewarded,
  };

  static Future<void> initSDK() async {
    try {
      return await _channel.invokeMethod('InitSdk');
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> setUser(String userId) async {
    try {
      await _channel
          .invokeMethod<void>('SetUser', <String, dynamic>{'UserId': userId});
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> setPrivacy(
      bool hasConsent, bool doNotSell, bool isAgeRestricted) async {
    try {
      await _channel.invokeMethod<void>('SetPrivacy', <String, dynamic>{
        'HasConsent': hasConsent,
        'DoNotSell': doNotSell,
        'IsAgeRestricted': isAgeRestricted
      });
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> initRewardAd(String unitId) async {
    try {
      await _channel.invokeMethod<void>(
          'InitRewardAd', <String, dynamic>{'UnitId': unitId});
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> showRewardVideo(AppLovinListener listener) async {
    try {
      _channel.setMethodCallHandler(
          (MethodCall call) async => handleMethod(call, listener));
      await _channel.invokeMethod<void>('ShowRewardVideo');
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<bool?> isRewardLoaded(AppLovinListener listener) async {
    return await _channel.invokeMethod('IsRewardLoaded');
  }

  static Future<void> initInterstitialAd(String unitId) async {
    try {
      await _channel.invokeMethod<void>(
          'InitInterAd', <String, dynamic>{'UnitId': unitId});
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> showInterstitialVideo(AppLovinListener listener) async {
    try {
      _channel.setMethodCallHandler(
          (MethodCall call) async => handleMethod(call, listener));
      await _channel.invokeMethod<void>('ShowInterVideo');
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<bool?> isInterstitialLoaded(AppLovinListener listener) async {
    return await _channel.invokeMethod('IsInterLoaded');
  }

  static Future<void> handleMethod(
      MethodCall call, AppLovinListener listener) async {
    listener(appLovinAdListener[call.method]);
  }
}
