#import "FlutterApplovinMaxPlugin.h"
#import <AppLovinSDK/AppLovinSDK.h>


@interface FlutterApplovinMaxPlugin()<MARewardedAdDelegate>
@property (nonatomic, strong) MARewardedAd *rewardedAd;
@property (nonatomic, assign) NSInteger retryAttempt;
@end
@implementation FlutterApplovinMaxPlugin

FlutterMethodChannel* globalMethodChannel;

- (void)initApplovin:(FlutterMethodCall*)call{
    NSString* unitId = call.arguments[@"UnitId"];
    [ALSdk shared].mediationProvider = @"max";
    [[ALSdk shared] initializeSdkWithCompletionHandler:^(ALSdkConfiguration *configuration) {
        // AppLovin SDK is initialized, start loading ads
    }];
    self.rewardedAd = [MARewardedAd sharedWithAdUnitIdentifier: unitId];
    self.rewardedAd.delegate = self;
    
    // Load the first ad
    [self.rewardedAd loadAd];
}


+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"flutter_applovin_max"
                                     binaryMessenger:[registrar messenger]];
    FlutterApplovinMaxPlugin* instance = [[FlutterApplovinMaxPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    globalMethodChannel = channel;
}



- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"Init" isEqualToString: call.method]) {
        [self initApplovin:call];
        result([NSNumber numberWithBool:YES]);

    } else if([@"ShowRewardVideo" isEqualToString: call.method]){
        if ( [self.rewardedAd isReady] ) {
            [self.rewardedAd showAd];
            result([NSNumber numberWithBool:YES]);
        }
    } else if([@"IsLoaded" isEqualToString: call.method]){
        result([NSNumber numberWithBool: [self.rewardedAd isReady]]);
    } else {
        result(FlutterMethodNotImplemented);
    }
    
}

- (void)didClickAd:(nonnull MAAd *)ad {
    [globalMethodChannel invokeMethod:@"AdClicked" arguments: nil];
}

- (void)didDisplayAd:(nonnull MAAd *)ad {
    
    [globalMethodChannel invokeMethod:@"AdDisplayed" arguments: nil];
}

- (void)didFailToDisplayAd:(nonnull MAAd *)ad withErrorCode:(NSInteger)errorCode {
    [globalMethodChannel invokeMethod:@"AdFailedToDisplay" arguments: nil];
    [self.rewardedAd loadAd];
}

- (void)didFailToLoadAdForAdUnitIdentifier:(nonnull NSString *)adUnitIdentifier withErrorCode:(NSInteger)errorCode {
    self.retryAttempt++;
    NSInteger delaySec = pow(2, MIN(6, self.retryAttempt));
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delaySec * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.rewardedAd loadAd];
    });
}

- (void)didHideAd:(nonnull MAAd *)ad {
    [globalMethodChannel invokeMethod:@"AdHidden" arguments: nil];
    [self.rewardedAd loadAd];
}

- (void)didLoadAd:(nonnull MAAd *)ad {
    [globalMethodChannel invokeMethod:@"AdLoaded" arguments: nil];
}

- (void)didCompleteRewardedVideoForAd:(nonnull MAAd *)ad {
    [globalMethodChannel invokeMethod:@"RewardedVideoCompleted" arguments: nil];
}

- (void)didRewardUserForAd:(nonnull MAAd *)ad withReward:(nonnull MAReward *)reward {
    [globalMethodChannel invokeMethod:@"UserRewarded" arguments: nil];}

- (void)didStartRewardedVideoForAd:(nonnull MAAd *)ad {
    [globalMethodChannel invokeMethod:@"RewardedVideoStarted" arguments: nil];}

@end
