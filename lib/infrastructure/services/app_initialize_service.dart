import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppInitializeService {
  static init() async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    await dotenv.load(fileName: ".env");

    await MobileAds.instance.initialize();
    await MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
      testDeviceIds: <String>[
        "93A670E61DF6E2C145C0EF28491A5B89"
      ], // ID de tu dispositivo de prueba
    ));
  }

  static removeFlutterNativeSplash() => FlutterNativeSplash.remove();
}
