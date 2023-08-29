import 'dart:math';

import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_applovin_max/banner.dart';
// import 'package:flutter_applovin_max/flutter_applovin_max.dart';
import 'package:multi_ads/networks.dart';
import 'package:multi_ads/src/data/applovin_data.dart';
import 'package:multi_ads/src/data/settings_data.dart';
import 'package:multi_ads/src/networks/ads.dart';
import 'package:multi_ads/src/utils/log.dart';

class ApplovinAD extends Ads {
  final ApplovinData _applovinData;
  final Settings _settings;

  ApplovinAD(this._applovinData, this._settings);

  Function? onRewarded;
  bool isRewardedVideoAvailable = false;
  bool isInterstitialVideoAvailable = false;
  var _interstitialRetryAttempt = 0;
  var _rewardedAdRetryAttempt = 0;

  // void listener(AppLovinAdListener? event) {
  //   Log.log(">> Applovin > $event");
  //   if (event == AppLovinAdListener.onUserRewarded) {
  //     Log.log('>> Applovin > 👍get reward');
  //   }
  // }
  Future<void> loadAppOpenAd() async {
    print("------> ${_applovinData.openAdsId}");
    AppLovinMAX.setAppOpenAdListener(AppOpenAdListener(
      onAdLoadedCallback: (ad) {},
      onAdLoadFailedCallback: (adUnitId, error) {},
      onAdDisplayedCallback: (ad) {},
      onAdDisplayFailedCallback: (ad, error) {
        AppLovinMAX.loadAppOpenAd(_applovinData.openAdsId);
      },
      onAdClickedCallback: (ad) {},
      onAdHiddenCallback: (ad) {
        AppLovinMAX.loadAppOpenAd(_applovinData.openAdsId);
      },
      onAdRevenuePaidCallback: (ad) {},
    ));
    AppLovinMAX.loadAppOpenAd(_applovinData.openAdsId);
  }

  void showAdIfAvailableOpenAds() async {
    print("try showing open ads ----------");
    bool isReady =
        (await AppLovinMAX.isAppOpenAdReady(_applovinData.openAdsId))!;
    if (isReady) {
      AppLovinMAX.showAppOpenAd(_applovinData.openAdsId);
    } else {
      AppLovinMAX.loadAppOpenAd(_applovinData.openAdsId);
    }
  }

  @override
  Future<void> init() async {
    bool? isInitialized = await AppLovinMAX.isInitialized();
    if (isInitialized == null || !isInitialized) {
      await AppLovinMAX.initialize(_applovinData.sdk_key);
      Log.log('>> Applovin > init' + _applovinData.sdk_key);
    }
    // if (_settings.inters.contains(Networks.applovin)) {
    //   loadInterstitialAd();
    // }
    // if (_settings.rewards.contains(Networks.applovin)) {
    //   loadRewardAd();
    // }
  }

  // banner
  @override
  Future<void> loadBannerAd(Function? onLoaded, Key key) async {
    // AppLovinMAX.createBanner(
    //     _applovinData.bannerId, AdViewPosition.bottomCenter);
  }

  @override
  Widget getBannerAdWidget(Key key) {
    // AppLovinMAX.showBanner(_applovinData.bannerId);
    return MaxAdView(
        adUnitId: _applovinData.bannerId,
        adFormat: AdFormat.banner,
        listener: AdViewAdListener(onAdLoadedCallback: (ad) {
          Log.log('Banner widget ad loaded from ' + ad.networkName);
        }, onAdLoadFailedCallback: (adUnitId, error) {
          Log.log('Banner widget ad failed to load with error code ' +
              error.code.toString() +
              ' and message: ' +
              error.message);
        }, onAdClickedCallback: (ad) {
          Log.log('Banner widget ad clicked');
        }, onAdExpandedCallback: (ad) {
          Log.log('Banner widget ad expanded');
        }, onAdCollapsedCallback: (ad) {
          Log.log('Banner widget ad collapsed');
        }));
  }

  @override
  Future<void> disposeBanner(Key key) async {
    // AppLovinMAX.destroyBanner(_applovinData.bannerId);
    // AppLovinMAX.hideBanner(_applovinData.bannerId);
  }

  // native
  @override
  Widget getNativeAdWidget() {
    return Container();
  }

  // inter
  @override
  Future<void> loadInterstitialAd() async {
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        Log.log('Interstitial ad loaded from ' + ad.networkName);
        _interstitialRetryAttempt = 0;
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        _interstitialRetryAttempt = _interstitialRetryAttempt + 1;
        int retryDelay = pow(2, min(6, _interstitialRetryAttempt)).toInt();
        Log.log('Interstitial ad failed to load with code ' +
            error.code.toString() +
            ' - retrying in ' +
            retryDelay.toString() +
            's');
        Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
          AppLovinMAX.loadInterstitial(_applovinData.interId);
        });
      },
      onAdDisplayedCallback: (ad) {},
      onAdDisplayFailedCallback: (ad, error) {},
      onAdClickedCallback: (ad) {},
      onAdHiddenCallback: (ad) {
        loadInterstitialAd();
      },
    ));
    AppLovinMAX.loadInterstitial(_applovinData.interId);
  }

  @override
  Future<void> showInterstitialAd() async {
    Log.log(">> Applovin > loading inter");
    isInterstitialVideoAvailable =
        (await AppLovinMAX.isInterstitialReady(_applovinData.interId)) ?? false;
    if (isInterstitialVideoAvailable) {
      Log.log(">> Applovin > inter loaded");
      AppLovinMAX.showInterstitial(_applovinData.interId);
      loadInterstitialAd();
    } else {
      loadInterstitialAd();
    }
  }

  // reward
  @override
  Future<void> loadRewardAd() async {
    AppLovinMAX.setRewardedAdListener(RewardedAdListener(
        onAdLoadedCallback: (ad) {
          Log.log('Rewarded ad loaded from ' + ad.networkName);
          _rewardedAdRetryAttempt = 0;
        },
        onAdLoadFailedCallback: (adUnitId, error) {
          _rewardedAdRetryAttempt = _rewardedAdRetryAttempt + 1;
          int retryDelay = pow(2, min(6, _rewardedAdRetryAttempt)).toInt();
          Log.log('Rewarded ad failed to load with code ' +
              error.code.toString() +
              ' - retrying in ' +
              retryDelay.toString() +
              's');
          Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
            AppLovinMAX.loadRewardedAd(_applovinData.rewardId);
          });
        },
        onAdDisplayedCallback: (ad) {},
        onAdDisplayFailedCallback: (ad, error) {},
        onAdClickedCallback: (ad) {},
        onAdHiddenCallback: (ad) {
          if (onRewarded != null) {
            onRewarded!();
          }
          onRewarded = null;
          loadRewardAd();
        },
        onAdReceivedRewardCallback: (ad, reward) {}));
    AppLovinMAX.loadRewardedAd(_applovinData.rewardId);
  }

  @override
  void showRewardAd(Function rewarded) async {
    isRewardedVideoAvailable =
        (await AppLovinMAX.isRewardedAdReady(_applovinData.rewardId)) ?? false;
    Log.log(">> Applovin > loading reward: $isRewardedVideoAvailable");
    if (isRewardedVideoAvailable) {
      AppLovinMAX.showRewardedAd(_applovinData.rewardId);
      onRewarded = rewarded;
      loadRewardAd();
    } else {
      loadRewardAd();
    }
  }
}
