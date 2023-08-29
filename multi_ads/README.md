## 1- installation
### pubspec.yaml
```yaml
dependencies:
    multi_ads:
    git:
      url: https://github.com/Res-team/multi_ads
      ref:  v1.0.0
```

### android/app/gradle
```gradle
dependencies {
    ...
    
    // Admob [ironsource, admob]
    implementation 'com.google.android.gms:play-services-ads:20.4.0'

    // Admob - mediation facebook
    implementation 'com.google.ads.mediation:facebook:6.8.0.0'

    // IronSource SDK
    implementation 'com.ironsource.sdk:mediationsdk:7.1.12.2'

    // IronSource SDK - mediation admob
    implementation 'com.ironsource.adapters:admobadapter:4.3.23'

    // IronSource SDK- mediation facebook
    implementation 'com.ironsource.adapters:facebookadapter:4.3.33'
    implementation 'androidx.annotation:annotation:1.0.0'
    implementation 'com.facebook.android:audience-network-sdk:6.8.0'

    // IronSource SDK - google play services needed
    implementation fileTree(dir: 'libs', include: ['*.jar'])
    implementation 'com.google.android.gms:play-services-appset:16.0.0'
    implementation 'com.google.android.gms:play-services-ads-identifier:17.0.0'
    implementation 'com.google.android.gms:play-services-basement:17.1.1'
    
    // applovin
    implementation 'com.applovin:applovin-sdk:+'
    implementation 'com.applovin.mediation:facebook-adapter:+'
    implementation 'com.android.support:recyclerview-v7:28.+'
    implementation 'com.android.support:appcompat-v7:28.+'
    ...
}
```

### manifest:
- outside application tag
```xml
<!-- IronSource -->
<uses-permission android:name="com.google.android.gms.permission.AD_ID"/>
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<!-- IronSource // -->
```
- inside application tag
- don't forget to change applovin key !
```xml
<!-- IronSource -->
<!-- Admob app id -->
<meta-data
  android:name="com.google.android.gms.ads.APPLICATION_ID"
  android:value="ca-app-pub-3940256099942544~3347511713"/>
<!-- Admob app id // -->

<!-- applovin -->
<meta-data
  android:name="applovin.sdk.key"
  android:value="applovin key here"/>
<!-- applovin // -->

<meta-data android:name="com.google.android.gms.version"
  android:value="@integer/google_play_services_version" />

<activity
    android:name="com.ironsource.sdk.controller.ControllerActivity"
    android:configChanges="orientation|screenSize"
    android:hardwareAccelerated="true" />
<activity
            android:name="com.ironsource.sdk.controller.InterstitialActivity"
            android:configChanges="orientation|screenSize"
            android:hardwareAccelerated="true"
            android:theme="@android:style/Theme.Translucent" />
<activity
            android:name="com.ironsource.sdk.controller.OpenUrlActivity"
            android:configChanges="orientation|screenSize"
            android:hardwareAccelerated="true"
            android:theme="@android:style/Theme.Translucent" />
<!-- IronSource // -->
```

## 2- declare a global MultiAds instance (exp lib/constants.dart or lib/globals.dart)
```dart
late final MultiAds gAds;
```

## 3- initialize sdk (splash screen)
```dart
// change json url
try {
  final response = await http.get(Uri.parse(jsonUrlHere));

  gAds = MultiAds(response.body);
  await gAds.init();
} catch (e) {
}
```

## 4- load ads (one time, exp: in splash screen)
```dart
await gAds.loadAds();
```

## 5- banner (widget)
```dart
CustomBanner(key: UniqueKey(), ads: gAds.bannerInstance)
```

## 6- show interstitial
```dart
gAds.interInstance.showInterstitialAd();
```

## 7- show rewarded
```dart
gAds.rewardInstance.showRewardAd(() {
  // on user rewarded
  // do what you want
});
