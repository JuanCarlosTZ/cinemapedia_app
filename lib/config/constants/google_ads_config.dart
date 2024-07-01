import 'package:flutter_dotenv/flutter_dotenv.dart';

class GoogleAdsConfig {
  static final configuration = _GoogleAdsConfiguration(
    //deviceAppId
    iOSAppAdsId: dotenv.env['appleAppAdsId'] ?? "",
    androidAppAdsId: dotenv.env['androidAppAdsId'] ?? "",

    //bannerAdUnitId
    // iOSUnitAdsId: dotenv.env['appleUnitAdsId'] ?? "",
    // androidUnitAdsId: dotenv.env['androidUnitAdsId'] ?? "",

    //bannerAdUnitId Test
    iOSUnitAdsId: 'ca-app-pub-3940256099942544/2934735716',
    androidUnitAdsId: 'ca-app-pub-3940256099942544/6300978111',
  );
}

class _GoogleAdsConfiguration {
  final String iOSAppAdsId;
  final String iOSUnitAdsId;
  final String androidAppAdsId;
  final String androidUnitAdsId;

  _GoogleAdsConfiguration({
    required this.iOSAppAdsId,
    required this.iOSUnitAdsId,
    required this.androidAppAdsId,
    required this.androidUnitAdsId,
  });
}
