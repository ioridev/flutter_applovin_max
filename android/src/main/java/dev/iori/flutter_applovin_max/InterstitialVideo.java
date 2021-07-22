package dev.iori.flutter_applovin_max;

import com.applovin.mediation.MaxAd;
import com.applovin.mediation.MaxError;
import com.applovin.mediation.MaxAdListener;
import com.applovin.mediation.ads.MaxInterstitialAd;

import io.flutter.Log;

public class InterstitialVideo implements MaxAdListener {
    private MaxInterstitialAd InterstitialAd;
    private int           retryAttempt;

    public void Init(String unitId) {
        InterstitialAd = new MaxInterstitialAd(unitId, FlutterApplovinMaxPlugin.getInstance().activity );
        InterstitialAd.setListener( this );
        InterstitialAd.loadAd();
    }

    public void Show() {
        try {
            if (InterstitialAd != null && InterstitialAd.isReady() && FlutterApplovinMaxPlugin.getInstance().activity != null)
                InterstitialAd.showAd();
        } catch (Exception e) {
            Log.e("AppLovin", e.toString());
        }
    }

    public boolean IsLoaded() {
        return InterstitialAd.isReady();
    }

    @Override
    public void onAdLoaded(MaxAd ad) {
        retryAttempt = 0;
        FlutterApplovinMaxPlugin.getInstance().Callback("AdLoaded");

    }


    @Override
    public void onAdDisplayed(MaxAd ad) {
        FlutterApplovinMaxPlugin.getInstance().Callback("AdDisplayed");

    }

    @Override
    public void onAdHidden(MaxAd ad) {
        FlutterApplovinMaxPlugin.getInstance().Callback("AdHidden");
        InterstitialAd.loadAd();
    }

    @Override
    public void onAdClicked(MaxAd ad) {
        FlutterApplovinMaxPlugin.getInstance().Callback("AdClicked");
    }

    @Override
    public void onAdLoadFailed(String adUnitId, MaxError error) {
        Log.e("AppLovin", "AdLoadFailed sdk error " + error);
        retryAttempt++;
        FlutterApplovinMaxPlugin.getInstance().Callback("AdLoadFailed");
    }

    @Override
    public void onAdDisplayFailed(MaxAd ad, MaxError error) {
        Log.e("AppLovin", "onAdDisplayFailed sdk error " + error);
        FlutterApplovinMaxPlugin.getInstance().Callback("AdFailedToDisplay");
    }

}
