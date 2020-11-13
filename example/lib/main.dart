import 'package:flutter/material.dart';

import 'package:flutter_applovin_max/flutter_applovin_max.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FlutterApplovinMax.init("YOUR_AD_UNIT_ID");
    super.initState();
  }

  listener(AppLovinAdListener event) {
    print(event);
    if (event == AppLovinAdListener.onUserRewarded) {
      print('👍get reward');
    }
  }

  bool isRewardedVideoAvailable = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () async {
              isRewardedVideoAvailable =
                  await FlutterApplovinMax.isLoaded(listener);
              if (isRewardedVideoAvailable) {
                FlutterApplovinMax.showRewardVideo(
                    (AppLovinAdListener event) => listener(event));
              }
            },
            child: Text('Show Reward Video'),
          ),
        ),
      ),
    );
  }
}
