import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppInitializeService {
  static init() async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    await dotenv.load(fileName: ".env");
    // 98B0087E4CE3D1DB61AF69CC12E93B1B
    await MobileAds.instance.initialize();
    // Configurar el ID del dispositivo de prueba

    RequestConfiguration requestConfiguration = RequestConfiguration(
      testDeviceIds: ['98B0087E4CE3D1DB61AF69CC12E93B1B'],
    );
    MobileAds.instance.updateRequestConfiguration(requestConfiguration);
  }

  static removeFlutterNativeSplash() => FlutterNativeSplash.remove();
}
