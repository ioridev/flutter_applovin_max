#import "FlutterApplovinMaxPlugin.h"
#import <AppLovinSDK/AppLovinSDK.h>


@interface FlutterApplovinMaxPlugin()<MARewardedAdDelegate>
@property (nonatomic, strong) MARewardedAd *rewardedAd;
@property (nonatomic, assign) NSInteger retryAttempt;
@end
@implementation FlutterApplovinMaxPlugin



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
}



- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"Init" isEqualToString: call.method]) {
        [self initApplovin:call];

    }else if([@"ShowRewardVideo" isEqualToString: call.method]){
        if ( [self.rewardedAd isReady] )
        {
            [self.rewardedAd showAd];
        }
    }
    else {
        result(FlutterMethodNotImplemented);
    }
    
}

- (void)didClickAd:(nonnull MAAd *)ad {
    
}

- (void)didDisplayAd:(nonnull MAAd *)ad {
    
}

- (void)didFailToDisplayAd:(nonnull MAAd *)ad withErrorCode:(NSInteger)errorCode {
    
}

- (void)didFailToLoadAdForAdUnitIdentifier:(nonnull NSString *)adUnitIdentifier withErrorCode:(NSInteger)errorCode {
    
}

- (void)didHideAd:(nonnull MAAd *)ad {
    
}

- (void)didLoadAd:(nonnull MAAd *)ad {
    
}

- (void)didCompleteRewardedVideoForAd:(nonnull MAAd *)ad {
    
}

- (void)didRewardUserForAd:(nonnull MAAd *)ad withReward:(nonnull MAReward *)reward {
    
}

- (void)didStartRewardedVideoForAd:(nonnull MAAd *)ad {
    
}

@end
