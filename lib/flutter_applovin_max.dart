library applovin;

import 'dart:async';

import 'package:flutter/services.dart';

enum AppLovinAdListener {
  adReceived,
  failedToReceiveAd,
  adDisplayed,
  adHidden,
  adClicked,
  adOpenedFullscreen,
  adClosedFullscreen,
  adLeftApplication,
  adFailedToDisplay
}

typedef AppLovinListener(AppLovinAdListener listener);

class FlutterApplovinMax {
  static final MethodChannel _channel = MethodChannel('flutter_applovin_max');
  static final Map<String, AppLovinAdListener> appLovinAdListener = {
    'AdReceived': AppLovinAdListener.adReceived,
    'FailedToReceiveAd': AppLovinAdListener.failedToReceiveAd,
    'AdDisplayed': AppLovinAdListener.adDisplayed,
    'AdHidden': AppLovinAdListener.adHidden,
    'AdClicked': AppLovinAdListener.adClicked,
    'AdOpenedFullscreen': AppLovinAdListener.adOpenedFullscreen,
    'AdClosedFullscreen': AppLovinAdListener.adClosedFullscreen,
    'AdLeftApplication': AppLovinAdListener.adLeftApplication,
    'AdFailedToDisplay': AppLovinAdListener.adFailedToDisplay,
  };

  static Future<void> init() async {
    try {
      await _channel.invokeMethod('Init');
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> hasUserConsent({bool enable = true}) async {
    try {
      await _channel.invokeMethod('HasUserConsent', {'Enable': enable});
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> requestInterstitial(AppLovinListener listener,
      {bool interstitial = true}) async {
    try {
      _channel.setMethodCallHandler(
          (MethodCall call) async => handleMethod(call, listener));
      await _channel
          .invokeMethod('RequestInterstitial', {'IsInter': interstitial});
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> showInterstitial({bool interstitial = true}) async {
    try {
      await _channel
          .invokeMethod('ShowInterstitial', {'IsInter': interstitial});
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> isAgeRestrictedUser({bool enable = true}) async {
    try {
      await _channel.invokeMethod('IsAgeRestrictedUser', {'Enable': enable});
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> handleMethod(
      MethodCall call, AppLovinListener listener) async {
    listener(appLovinAdListener[call.method]);
  }
}
