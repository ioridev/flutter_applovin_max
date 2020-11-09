package dev.iori.flutter_applovin_max;

import com.applovin.adview.AppLovinIncentivizedInterstitial;
import com.applovin.sdk.AppLovinAd;
import com.applovin.sdk.AppLovinAdClickListener;
import com.applovin.sdk.AppLovinAdDisplayListener;
import com.applovin.sdk.AppLovinAdLoadListener;
import com.applovin.sdk.AppLovinAdRewardListener;
import com.applovin.sdk.AppLovinAdVideoPlaybackListener;
import com.applovin.mediation.MaxAd;
import com.applovin.mediation.MaxReward;
import com.applovin.mediation.MaxRewardedAdListener;
import com.applovin.mediation.ads.MaxRewardedAd;


import java.util.Map;

import io.flutter.Log;

public class RewardedVideo implements MaxRewardedAdListener {
    private MaxRewardedAd RewardedAd;
    private int           retryAttempt;


    public void Show() {
        RewardedAd = MaxRewardedAd.getInstance( "unit_id", FlutterApplovinMaxPlugin.getInstance().activity );
        RewardedAd.setListener( this );
        RewardedAd.loadAd();
        try {
            if (RewardedAd != null && RewardedAd.isReady() && FlutterApplovinMaxPlugin.getInstance().activity != null)
                RewardedAd.showAd();
        } catch (Exception e) {
            Log.e("AppLovin", e.toString());
        }
    }


    @Override
    public void onAdLoaded(MaxAd ad) {
        retryAttempt = 0;
        FlutterApplovinMaxPlugin.getInstance().Callback("AdLoaded");

    }

    @Override
    public void onAdLoadFailed(final String adUnitId, final int errorCode) {
        Log.e("AppLovin", "AdLoadFailed sdk error " + errorCode);
        FlutterApplovinMaxPlugin.getInstance().Callback("AdLoadFailed");
    }

    @Override
    public void onAdDisplayed(MaxAd ad) {
        FlutterApplovinMaxPlugin.getInstance().Callback("AdDisplayed");

    }

    @Override
    public void onAdHidden(MaxAd ad) {
        FlutterApplovinMaxPlugin.getInstance().Callback("AdHidden");
        RewardedAd.loadAd();
    }

    @Override
    public void onAdClicked(MaxAd ad) {
        FlutterApplovinMaxPlugin.getInstance().Callback("AdClicked");
    }

    @Override
    public void onAdDisplayFailed(MaxAd ad, int errorCode) {
        Log.e("AppLovin", "onAdDisplayFailed sdk error " + errorCode);
        FlutterApplovinMaxPlugin.getInstance().Callback("AdFailedToDisplay");
    }


    @Override
    public void onRewardedVideoStarted(MaxAd ad) {
        FlutterApplovinMaxPlugin.getInstance().Callback("RewardedVideoStarted");


    }

    @Override
    public void onRewardedVideoCompleted(MaxAd ad) {
        FlutterApplovinMaxPlugin.getInstance().Callback("RewardedVideoCompleted");

    }

    @Override
    public void onUserRewarded(MaxAd ad, MaxReward reward) {
        FlutterApplovinMaxPlugin.getInstance().Callback("UserRewarded");


    }
}

