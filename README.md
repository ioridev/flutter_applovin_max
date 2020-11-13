# flutter_applovin_max

Flutter plugin for showing [applovin MAX  mediation](https://www.applovin.com/max/) ads rewardvideo (Android & Ios).

MAX is AppLovin's in-app monetization solution.

Move beyond the traditional monetization solution and integrate MAX. MAX is a single unbiased auction where advertisers get equal access to all ad inventory and bid simultaneously, which drives more competition and higher CPMs for you. You can read more about it [here](https://www.applovin.com/max-header-bidding).

To request an invite for MAX, apply [here](https://try.applovin.com/applovin-max-application).

Please check out our [documentation](https://dash.applovin.com/documentation/mediation/ios/getting-started) to get started on integrating and enabling mediated networks using our guides.  

## Getting Started

Add inside the <application> tag. 
Android
```
<meta-data android:name="applovin.sdk.key"
    android:value="YOUR_SDK_KEY"/>
```
IOS info.plist
```
<key>AppLovinSdkKey</key
<string>YOUR_SDK_KEY</string>
	<key>SKAdNetworkItems</key>
	<array>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>2U9PT9HC89.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4468km3ulz.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4FZDC2EVR5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>7UG5ZH24HU.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>8s468mfl3y.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9RD848Q2BZ.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9T245VHMPL.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>av6w8kgt66.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>F38H382JLK.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>hs6bdukanm.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>KBD757YWX3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ludvb6z3bs.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>M8DBW4SV7C.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>mlmmfzh3r3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>prcb7njmu6.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>t38b2kh725.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>TL55SBB4FM.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>WZMMZ9FP6W.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>YCLNXRL5PM.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ydx93a7ass.skadnetwork</string>
    </dict>
</array>
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-3940256099942544~1458002511</string>
```
## Preparing Mediated Networks  
### IOS
The following SDK is included in the ios plugin.　　
```  
AdColony  
Facebook  
InMobi  
ByteDance  
Smaato  
Tapjoy  
Vungle  
Chartboost  
Fyber  
Google  
IronSource  
nMaio  
MyTarget  
TencentGDT  
UnityAds  
Yandex  
```
### Android
For Android, refer to the document and add it to the app  
[https://dash.applovin.com/documentation/mediation/android/mediation-adapters](https://dash.applovin.com/documentation/mediation/android/mediation-adapters)  
#### important point  
When installing the iron source, the following error is output.  
`Suggestion: add 'tools:replace="android:label"' to <application> element at AndroidManifest.xml:16:5-39:19 to override.`  
You could, as the error says, add tools:replace="android:label" to your <application> node in your manifest  
See the example for [flutter_applovin_max/example/Android](https://github.com/ioridev/flutter_applovin_max/blob/main/example/android/app/src/main/AndroidManifest.xml)  
``` <application tools:replace="android:label"
        android:name="io.flutter.app.FlutterApplication"
        android:label="flutter_applovin_max_example"
        android:icon="@mipmap/ic_launcher">
```  
add schemas xmlns:tools="http://schemas.android.com/tools"  
`<manifest xmlns:android="http://schemas.android.com/apk/res/android"package="dev.iori.flutter_applovin_max_example" xmlns:tools="http://schemas.android.com/tools">`  


## Using this plugin
see directory example 

Visit [applovin MAX](https://www.applovin.com/max/) website to know more 

## このプラグインについて  
このプラグインは [applovin MAX](https://www.applovin.com/max/)のリワードビデオをFlutterアプリで利用できるようにネイティブSDKを統合します。
これにより Flutter アプリでメディエーション機能を利用したリワード動画を実装できます。
