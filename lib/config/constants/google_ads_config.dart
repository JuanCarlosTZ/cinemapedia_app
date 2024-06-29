import 'package:flutter_dotenv/flutter_dotenv.dart';

class GoogleAdsConfig {
  static final configuration = _GoogleAdsConfiguration(
    //deviceAppId
    appleAppAdsId: dotenv.env['appleAppAdsId'] ?? "",
    androidAppAdsId: dotenv.env['androidAppAdsId'] ?? "",

    //bannerAdUnitId
    appleUnitAdsId: dotenv.env['appleUnitAdsId'] ?? "",
    androidUnitAdsId: dotenv.env['androidUnitAdsId'] ?? "",
  );
}

class _GoogleAdsConfiguration {
  final String appleAppAdsId;
  final String appleUnitAdsId;
  final String androidAppAdsId;
  final String androidUnitAdsId;

  _GoogleAdsConfiguration({
    required this.appleAppAdsId,
    required this.appleUnitAdsId,
    required this.androidAppAdsId,
    required this.androidUnitAdsId,
  });
}
