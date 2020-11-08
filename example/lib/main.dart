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
    FlutterApplovinMax.init();
    super.initState();
  }

  listener(AppLovinAdListener event, bool isInter) {
    print(event);
    if (event == AppLovinAdListener.adReceived) {
      FlutterApplovinMax.showInterstitial(interstitial: isInter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () => FlutterApplovinMax.requestInterstitial(
                  (AppLovinAdListener event) => listener(event, true),
                  interstitial: true),
              child: Text('Show Interstitial'),
            ),
            RaisedButton(
              onPressed: () => FlutterApplovinMax.requestInterstitial(
                  (AppLovinAdListener event) => listener(event, false),
                  interstitial: true),
              child: Text('Show Interstitial Reward'),
            ),
          ],
        ),
      ),
    );
  }
}
