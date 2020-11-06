package dev.iori.flutter_applovin_max;

import android.app.Activity;
import android.content.Context;
import androidx.annotation.NonNull;
import com.applovin.sdk.AppLovinPrivacySettings;
import com.applovin.sdk.AppLovinSdk;
import io.flutter.Log;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.StandardMethodCodec;
import io.flutter.plugin.platform.PlatformViewRegistry;

public class FlutterApplovinMaxPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
    private static FlutterApplovinMaxPlugin instance;
    private static Interstitial instanceInter;
    private static RewardedVideo instanceReward;
    private static Context context;
    private static MethodChannel channel;
    public static Activity activity;

    public static FlutterApplovinMaxPlugin getInstance() {
        return instance;
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        this.RegistrarBanner(flutterPluginBinding.getFlutterEngine().getPlatformViewsController().getRegistry());
        this.onAttachedToEngine(flutterPluginBinding.getApplicationContext(), flutterPluginBinding.getBinaryMessenger());
    }

    public static void registerWith(Registrar registrar) {
        if (instance == null) {
            instance = new FlutterApplovinMaxPlugin();
        }
        instance.RegistrarBanner(registrar.platformViewRegistry());
        instance.onAttachedToEngine(registrar.context(), registrar.messenger());
    }

    public void RegistrarBanner(PlatformViewRegistry registry){
        registry.registerViewFactory("/Banner", new BannerFactory());
    }

    public void onAttachedToEngine(Context applicationContext, BinaryMessenger messenger) {
        if (channel != null) {
            return;
        }
        instance = new FlutterApplovinMaxPlugin();
        Log.i("AppLovin Plugin", "onAttachedToEngine");
        this.context = applicationContext;
        channel = new MethodChannel(messenger, "flutter_applovin_max", StandardMethodCodec.INSTANCE);
        channel.setMethodCallHandler(this);
    }

    public FlutterApplovinMaxPlugin() {
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        try {
            switch (call.method) {
                case "Init":
                    AppLovinSdk.initializeSdk(context);
                    result.success(Boolean.TRUE);
                    break;
                case "HasUserConsent":
                    AppLovinPrivacySettings.setHasUserConsent((Boolean) call.argument("Enable"), context);
                    result.success(Boolean.TRUE);
                    break;
                case "IsAgeRestrictedUser":
                    AppLovinPrivacySettings.setIsAgeRestrictedUser((Boolean) call.argument("Enable"), context);
                    result.success(Boolean.TRUE);
                    break;
                case "ShowInterstitial":
                    if (call.argument("IsInter"))
                        instanceInter.Show();
                    else
                        instanceReward.Show();
                    result.success(Boolean.TRUE);
                    break;
                case "RequestInterstitial":
                    if (call.argument("IsInter"))
                        instanceInter.Request();
                    else
                        instanceReward.Request();
                    result.success(Boolean.TRUE);
                    break;
                default:
                    result.notImplemented();
            }
        } catch (Exception err) {
            Log.e("Method error", err.toString());
            result.notImplemented();
        }
    }

    static public void Callback(final String method) {
        if (instance.context != null && instance.channel != null && instance.activity != null) {
            instance.activity.runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    instance.channel.invokeMethod(method, null);
                }
            });
        } else {
            Log.e("AppLovin", "instance method channel not created");
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        this.context = null;
        this.channel.setMethodCallHandler(null);
        this.channel = null;
    }

    @Override
    public void onAttachedToActivity(ActivityPluginBinding binding) {
        this.activity = binding.getActivity();
        if (instance.instanceInter == null) {
            instance.instanceInter = new Interstitial(binding.getActivity().getApplicationContext());
            instance.instanceReward = new RewardedVideo();
            Log.i("AppLovin Plugin", "Instances created");
        }
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
    }

    @Override
    public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {
        this.activity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivity() { }
}