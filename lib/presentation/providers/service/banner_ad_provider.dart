import 'package:cinemapedia_app/infrastructure/services/google_ads_service.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

typedef OnAdCallback = Future<BannerAd> Function(Ad)?;

class GoogleAdsStateNotifier extends StateNotifier<BannerAd?> {
  final GoogleAdsService googleAdsService;
  BannerAd? _bannerAd;

  GoogleAdsStateNotifier(this.googleAdsService) : super(null) {
    loadAd();
  }

  void loadAd() {
    if (state != null) null;
    _bannerAd = googleAdsService.homeBannerAd((ad) {
      state = _bannerAd;
    });
    state = _bannerAd;
  }
}

final googleannerAdProvider = Provider<GoogleAdsService>((ref) {
  return GoogleAdsService();
});

final homeBannerAdProvider =
    StateNotifierProvider.autoDispose<GoogleAdsStateNotifier, BannerAd?>((ref) {
  final googleAdsService = ref.watch(googleannerAdProvider);
  return GoogleAdsStateNotifier(googleAdsService);
});

final categoryBannerAdProvider =
    StateNotifierProvider.autoDispose<GoogleAdsStateNotifier, BannerAd?>((ref) {
  final googleAdsService = ref.watch(googleannerAdProvider);
  return GoogleAdsStateNotifier(googleAdsService);
});

final favoriteBannerAdProvider =
    StateNotifierProvider.autoDispose<GoogleAdsStateNotifier, BannerAd?>((ref) {
  final googleAdsService = ref.watch(googleannerAdProvider);
  return GoogleAdsStateNotifier(googleAdsService);
});
