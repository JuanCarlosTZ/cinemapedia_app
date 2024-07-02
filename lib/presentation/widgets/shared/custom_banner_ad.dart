import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CustomBannerAd extends StatelessWidget {
  final BannerAd bannerAd;
  const CustomBannerAd({super.key, required this.bannerAd});

  @override
  Widget build(BuildContext context) {
    if (bannerAd.responseInfo == null) return const SizedBox();
    return SizedBox(
      width: double.infinity,
      height: bannerAd.size.height.toDouble(),
      child: AdWidget(ad: bannerAd),
    );
  }
}
