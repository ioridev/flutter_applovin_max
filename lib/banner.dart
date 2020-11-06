import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'flutter_applovin_max.dart';

enum BannerAdSize {
  banner,
  mrec,
  leader,
}

class BannerPx {
  final double width;
  final double height;

  BannerPx(this.width, this.height);
}

class BannerView extends StatelessWidget {
  final AppLovinListener listener;
  final Map<BannerAdSize, String> sizes = {
    BannerAdSize.banner: 'BANNER',
    BannerAdSize.leader: 'LEADER',
    BannerAdSize.mrec: 'MREC'
  };
  final Map<BannerAdSize, BannerPx> sizesNum = {
    BannerAdSize.banner: new BannerPx(350, 50),
    BannerAdSize.leader: new BannerPx(double.infinity, 90),
    BannerAdSize.mrec: new BannerPx(300, 250)
  };
  final BannerAdSize size;

  BannerView(this.listener, this.size, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.sizesNum[this.size].width,
      height: this.sizesNum[this.size].height,
      child: AndroidView(
        viewType: '/Banner',
        key: UniqueKey(),
        creationParams: {'Size': this.sizes[this.size]},
        creationParamsCodec: StandardMessageCodec(),
        onPlatformViewCreated: (int i) {
          final channel = MethodChannel('flutter_applovin_max');
          channel.setMethodCallHandler((MethodCall call) async =>
              FlutterApplovinMax.handleMethod(call, listener));
        },
      ),
    );
  }
}
