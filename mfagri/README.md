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