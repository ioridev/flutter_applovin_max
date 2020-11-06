package dev.iori.flutter_applovin_max;

import com.applovin.adview.AppLovinIncentivizedInterstitial;
import com.applovin.sdk.AppLovinAd;
import com.applovin.sdk.AppLovinAdClickListener;
import com.applovin.sdk.AppLovinAdDisplayListener;
import com.applovin.sdk.AppLovinAdLoadListener;
import com.applovin.sdk.AppLovinAdRewardListener;
import com.applovin.sdk.AppLovinAdVideoPlaybackListener;

import java.util.Map;

import io.flutter.Log;

public class RewardedVideo implements AppLovinAdLoadListener, AppLovinAdRewardListener,
        AppLovinAdVideoPlaybackListener, AppLovinAdDisplayListener, AppLovinAdClickListener {

    private AppLovinIncentivizedInterstitial RewardedAd;

    public RewardedVideo() {
        if (FlutterApplovinMaxPlugin.getInstance().activity != null)
            this.RewardedAd = AppLovinIncentivizedInterstitial.create(FlutterApplovinMaxPlugin.getInstance().activity);
    }

    public void Show() {
        try {
            if (this.RewardedAd != null && this.RewardedAd.isAdReadyToDisplay() && FlutterApplovinMaxPlugin.getInstance().activity != null)
                this.RewardedAd.show(FlutterApplovinMaxPlugin.getInstance().activity, this, this,
                        this, this);
        } catch (Exception e) {
            Log.e("AppLovin", e.toString());
        }
    }

    public void Request() {
        this.RewardedAd.preload(this);
    }

    @Override
    public void adReceived(AppLovinAd ad) {
        FlutterApplovinMaxPlugin.getInstance().Callback("AdReceived");
    }

    @Override
    public void failedToReceiveAd(int errorCode) {
        Log.e("AppLovin", "FailedToReceiveAd sdk error " + errorCode);
        FlutterApplovinMaxPlugin.getInstance().Callback("FailedToReceiveAd");
    }

    @Override
    public void userRewardVerified(AppLovinAd ad, Map<String, String> response) {
        FlutterApplovinMaxPlugin.getInstance().Callback("UserRewardVerified");
    }

    @Override
    public void userOverQuota(AppLovinAd ad, Map<String, String> response) {
        FlutterApplovinMaxPlugin.getInstance().Callback("UserOverQuota");
    }

    @Override
    public void userRewardRejected(AppLovinAd ad, Map<String, String> response) {
        FlutterApplovinMaxPlugin.getInstance().Callback("UserRewardRejected");
    }

    @Override
    public void validationRequestFailed(AppLovinAd ad, int errorCode) {
        Log.e("AppLovin", "ValidationRequestFailed sdk error " + errorCode);
        FlutterApplovinMaxPlugin.getInstance().Callback("ValidationRequestFailed");
    }

    @Override
    public void userDeclinedToViewAd(AppLovinAd ad) {
        FlutterApplovinMaxPlugin.getInstance().Callback("UserDeclinedToViewAd");
    }

    @Override
    public void videoPlaybackBegan(AppLovinAd ad) {
        FlutterApplovinMaxPlugin.getInstance().Callback("VideoPlaybackBegan");
    }

    @Override
    public void videoPlaybackEnded(AppLovinAd ad, double percentViewed, boolean fullyWatched) {
        FlutterApplovinMaxPlugin.getInstance().Callback("VideoPlaybackEnded");
    }

    @Override
    public void adClicked(AppLovinAd ad) {
        FlutterApplovinMaxPlugin.getInstance().Callback("AdClicked");
    }

    @Override
    public void adDisplayed(AppLovinAd ad) {
        FlutterApplovinMaxPlugin.getInstance().Callback("AdDisplayed");
    }

    @Override
    public void adHidden(AppLovinAd ad) {
        FlutterApplovinMaxPlugin.getInstance().Callback("AdHidden");
    }
}
