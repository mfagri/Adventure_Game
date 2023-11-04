## image 
<div>
 <img src="https://assetstorev1-prd-cdn.unity3d.com/key-image/ad020d03-97f5-4835-9559-ffd4426b729b.webp" width="200">
<div/>

## 0- show openads
```dart
g_ads.openAdsInstance.showAdIfAvailableOpenAds();
```

## 1- banner (widget)
```dart
CustomBanner(key: UniqueKey(), ads: gAds.bannerInstance)
```

## 2- show interstitial
```dart
gAds.interInstance.showInterstitialAd();
```

## 3- show rewarded
```dart
gAds.rewardInstance.showRewardAd(() {
  // when user rewarded
});
```
