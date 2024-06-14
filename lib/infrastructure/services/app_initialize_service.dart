import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class AppInitializeService {
  static init() async {
    await dotenv.load(fileName: ".env");
    FlutterNativeSplash.preserve(
        widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  }

  static removeFlutterNativeSplash() => FlutterNativeSplash.remove();
}
