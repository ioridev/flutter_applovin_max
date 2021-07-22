package dev.iori.flutter_applovin_max;
import android.content.Context;

import java.util.HashMap;

import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class BannerFactory extends PlatformViewFactory {
    public BannerFactory() {
        super(StandardMessageCodec.INSTANCE);
    }

    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        return new BannerMax(context, (HashMap) args);
    }
}
