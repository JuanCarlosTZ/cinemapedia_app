import 'dart:io';
import 'package:cinemapedia_app/config/configs.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAdsService {
  final homeAdUnitId = Platform.isAndroid
      ? GoogleAdsConfig.configuration.androidUnitAdsId
      : GoogleAdsConfig.configuration.appleUnitAdsId;

  // final homeAdUnitId = Platform.isAndroid
  //     ? 'ca-app-pub-3940256099942544/6300978111'
  //     : 'ca-app-pub-3940256099942544/2934735716';

  /// Loads a banner ad.
  BannerAd homeBannerAd(void Function(Ad)? onAdLoaded) {
    return BannerAd(
      adUnitId: homeAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }
}
