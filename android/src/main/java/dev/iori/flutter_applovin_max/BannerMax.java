package dev.iori.flutter_applovin_max;

import android.app.Activity;
import android.content.Context;
import android.view.Gravity;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

import com.applovin.adview.AppLovinAdView;
import com.applovin.adview.AppLovinAdViewDisplayErrorCode;
import com.applovin.adview.AppLovinAdViewEventListener;

import com.applovin.mediation.MaxAd;
import com.applovin.mediation.MaxReward;
import com.applovin.mediation.MaxAdViewAdListener;

import com.applovin.mediation.ads.MaxAdView;
import com.applovin.sdk.AppLovinAd;
import com.applovin.sdk.AppLovinAdClickListener;
import com.applovin.sdk.AppLovinAdDisplayListener;
import com.applovin.sdk.AppLovinAdLoadListener;
import com.applovin.sdk.AppLovinAdSize;
import com.applovin.sdk.AppLovinSdkUtils;
import java.util.HashMap;
import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.platform.PlatformView;


public class BannerMax extends FlutterActivity implements PlatformView, AppLovinAdClickListener, AppLovinAdDisplayListener,
        AppLovinAdViewEventListener, AppLovinAdLoadListener {
    final MaxAdView Banner;
    final HashMap<String, AppLovinAdSize> sizes = new HashMap<String, AppLovinAdSize>() {
        {
            put("BANNER", AppLovinAdSize.BANNER);
            put("MREC", AppLovinAdSize.MREC);
            put("LEADER", AppLovinAdSize.LEADER);
        }
    };

    AppLovinAdSize size;
    String AdUnitId;

    public BannerMax(Context context, HashMap args) {
        Log.d("Banner Max Android", "Constructor");
        try {
            this.size = this.sizes.get(args.get("Size"));
        } catch (Exception e) {
            this.size = AppLovinAdSize.BANNER;
        }
        try {
            this.AdUnitId = args.get("UnitId").toString();
        } catch (Exception e) {
            this.AdUnitId = "YOUR_AD_UNIT_ID";
        }

        this.Banner = new MaxAdView( AdUnitId, FlutterApplovinMaxPlugin.activity);
        final FrameLayout.LayoutParams layout = new FrameLayout.LayoutParams(
                this.dpToPx(context, this.size.getWidth()), this.dpToPx(context, this.size.getHeight()));
        layout.gravity = Gravity.CENTER;
        this.Banner.setLayoutParams(layout);
        this.Listeners();
        this.Banner.loadAd();
    }

    public void Listeners() {
        /*
        if (this.Banner != null) {
            this.Banner.setAdViewEventListener(this);
            this.Banner.setAdLoadListener(this);
            this.Banner.setAdDisplayListener(this);
            this.Banner.setAdClickListener(this);
        }
        */

    }

    int dpToPx(Context context, int dp) {
        return AppLovinSdkUtils.dpToPx(context, dp);
    }

    @Override
    public View getView() {
        return this.Banner;
    }

    @Override
    public void dispose() {
        //this.Banner.destroy();
    }

    @Override
    public void adOpenedFullscreen(AppLovinAd ad, AppLovinAdView adView) {
        FlutterApplovinMaxPlugin.getInstance().Callback("AdOpenedFullscreen");
    }

    @Override
    public void adClosedFullscreen(AppLovinAd ad, AppLovinAdView adView) {
        FlutterApplovinMaxPlugin.getInstance().Callback("AdClosedFullscreen");
    }

    @Override
    public void adLeftApplication(AppLovinAd ad, AppLovinAdView adView) {
        FlutterApplovinMaxPlugin.getInstance().Callback("AdLeftApplication");
    }

    @Override
    public void adFailedToDisplay(AppLovinAd ad, AppLovinAdView adView, AppLovinAdViewDisplayErrorCode code) {
        //this.Banner.loadNextAd();
        FlutterApplovinMaxPlugin.getInstance().Callback("AdFailedToDisplay");
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
        //this.Banner.loadNextAd();
        FlutterApplovinMaxPlugin.getInstance().Callback("AdHidden");
    }

    @Override
    public void adReceived(AppLovinAd ad) {
        FlutterApplovinMaxPlugin.getInstance().Callback("AdReceived");
    }

    @Override
    public void failedToReceiveAd(int errorCode) {
        //this.Banner.loadNextAd();
        Log.e("AppLovin", "FailedToReceiveAd error sdk code " + errorCode);
        FlutterApplovinMaxPlugin.getInstance().Callback("FailedToReceiveAd");
    }
}
