import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppInitializeService {
  static init() async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    await dotenv.load(fileName: ".env");
    // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]);
    await MobileAds.instance.initialize();
  }

  static removeFlutterNativeSplash() => FlutterNativeSplash.remove();
}
