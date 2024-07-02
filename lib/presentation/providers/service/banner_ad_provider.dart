import 'package:cinemapedia_app/infrastructure/services/google_ads_service.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class StateBannerAd {
  final BannerAd bannerAd;

  StateBannerAd({required this.bannerAd});

  StateBannerAd copyWith({BannerAd? bannerAd}) {
    return StateBannerAd(bannerAd: bannerAd ?? this.bannerAd);
  }
}

typedef OnAdCallback = Future<BannerAd> Function(Ad)?;

class GoogleAdsStateNotifier extends StateNotifier<StateBannerAd?> {
  final GoogleAdsService googleAdsService;
  BannerAd? _bannerAd;

  GoogleAdsStateNotifier(this.googleAdsService) : super(null) {
    loadAd();
  }

  void loadAd() {
    if (state != null) return;

    _bannerAd = googleAdsService.homeBannerAd((ad) {
      state = state!.copyWith(bannerAd: _bannerAd);
    });

    if (_bannerAd == null) {
      state = null;
      return;
    }

    state = StateBannerAd(bannerAd: _bannerAd!);
  }
}

final googleannerAdProvider = Provider<GoogleAdsService>((ref) {
  return GoogleAdsService();
});

final homeBannerAdProvider =
    StateNotifierProvider.autoDispose<GoogleAdsStateNotifier, StateBannerAd?>(
        (ref) {
  final googleAdsService = ref.watch(googleannerAdProvider);
  return GoogleAdsStateNotifier(googleAdsService);
});

final categoryBannerAdProvider =
    StateNotifierProvider.autoDispose<GoogleAdsStateNotifier, StateBannerAd?>(
        (ref) {
  final googleAdsService = ref.watch(googleannerAdProvider);
  return GoogleAdsStateNotifier(googleAdsService);
});

final favoriteBannerAdProvider =
    StateNotifierProvider.autoDispose<GoogleAdsStateNotifier, StateBannerAd?>(
        (ref) {
  final googleAdsService = ref.watch(googleannerAdProvider);
  return GoogleAdsStateNotifier(googleAdsService);
});
