import 'package:cinemapedia_app/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia_app/config/theme/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  runApp(const ProviderScope(
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter().appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme,
    );
  }
}
