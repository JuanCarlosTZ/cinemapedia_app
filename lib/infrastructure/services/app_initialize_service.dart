import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppInitializeService {
  static init() async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    await dotenv.load(fileName: ".env");
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await MobileAds.instance.initialize();

    RequestConfiguration requestConfiguration = RequestConfiguration(
      testDeviceIds: ['98B0087E4CE3D1DB61AF69CC12E93B1B'],
    );
    MobileAds.instance.updateRequestConfiguration(requestConfiguration);
  }

  static removeFlutterNativeSplash() => FlutterNativeSplash.remove();
}
