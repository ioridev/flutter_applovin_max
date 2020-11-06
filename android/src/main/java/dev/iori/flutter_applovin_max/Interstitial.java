package dev.iori.flutter_applovin_max;

import android.content.Context;
import com.applovin.adview.AppLovinInterstitialAd;
import com.applovin.adview.AppLovinInterstitialAdDialog;
import com.applovin.sdk.AppLovinAd;
import com.applovin.sdk.AppLovinAdClickListener;
import com.applovin.sdk.AppLovinAdDisplayListener;
import com.applovin.sdk.AppLovinAdLoadListener;
import com.applovin.sdk.AppLovinAdSize;
import com.applovin.sdk.AppLovinAdVideoPlaybackListener;
import com.applovin.sdk.AppLovinSdk;

import io.flutter.Log;

@SuppressWarnings("ALL")
public class Interstitial implements AppLovinAdLoadListener,
        AppLovinAdDisplayListener, AppLovinAdClickListener, AppLovinAdVideoPlaybackListener {

    private AppLovinInterstitialAdDialog interstitialAd;
    private AppLovinAd currentAd;
    private final Context context;

    Interstitial(Context context) {
        this.context = context;
        this.init();
    }

    public void init() {
        this.interstitialAd = AppLovinInterstitialAd.create(AppLovinSdk.getInstance(context), context);
        this.interstitialAd.setAdClickListener(this);
        this.interstitialAd.setAdDisplayListener(this);
        this.interstitialAd.setAdVideoPlaybackListener(this);
    }

    public void Request() {
        AppLovinSdk.getInstance(this.context).getAdService().loadNextAd(AppLovinAdSize.INTERSTITIAL, this);
    }

    public void Show() {
        try {
            if (this.currentAd != null)
                this.interstitialAd.showAndRender(this.currentAd);
            else
                Log.e("AppLovin", "Ad not load instance null");
        } catch (Exception e) {
            Log.e("AppLovin", "Ad not load instance null");
        }
    }

    @Override
    public void adReceived(AppLovinAd ad) {
        this.currentAd = ad;
        FlutterApplovinMaxPlugin.getInstance().Callback("AdReceived");
    }

    @Override
    public void failedToReceiveAd(int errorCode) {
        Log.e("AppLovin", "FailedToReceiveAd error sdk code " + errorCode);
        FlutterApplovinMaxPlugin.getInstance().Callback("FailedToReceiveAd");
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
        this.currentAd = null;
        FlutterApplovinMaxPlugin.getInstance().Callback("AdHidden");
    }

    @Override
    public void videoPlaybackBegan(AppLovinAd ad) {
        FlutterApplovinMaxPlugin.getInstance().Callback("VideoPlaybackBegan");
    }

    @Override
    public void videoPlaybackEnded(AppLovinAd ad, double percentViewed, boolean fullyWatched) {
        FlutterApplovinMaxPlugin.getInstance().Callback("VideoPlaybackEnded");
    }
}
