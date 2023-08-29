import 'package:multi_ads/multi_ads.dart';

// https://drive.google.com/file/d//view?usp=sharing
class Constants {
  static const jsonConfigUrl =
      'https://drive.google.com/uc?export=download&id=1jV7q8shoO3GcK32Fv4qOqQPeq3OwSD2Q';
}

late Map<String, dynamic> configApp;
late final MultiAds g_ads;

Future<bool> willPopCallback() async {
  // g_ads.interInstance.showInterstitialAd();
  return true;
}
