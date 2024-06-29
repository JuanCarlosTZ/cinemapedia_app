import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CustomBannerAd extends StatelessWidget {
  final BannerAd bannerAd;
  const CustomBannerAd({super.key, required this.bannerAd});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // width: double.infinity,
      // width: bannerAd.size.width.toDouble(),
      height: bannerAd.size.height.toDouble(),
      child: AdWidget(ad: bannerAd),
    );
  }
}
