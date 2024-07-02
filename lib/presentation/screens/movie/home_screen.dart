import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia_app/config/configs.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:cinemapedia_app/presentation/views/views.dart';
import 'package:cinemapedia_app/presentation/widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {
  static String name = 'home_screen';
  final int page;
  const HomeScreen({super.key, required this.page});

  final List<Widget> pageWiews = const [
    HomeView(),
    CategoryView(),
    FavoriteView(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeBannerAd = ref.watch(homeBannerAdProvider)?.bannerAd;
    final categoryBannerAd = ref.watch(categoryBannerAdProvider)?.bannerAd;
    final favoriteBannerAd = ref.watch(favoriteBannerAdProvider)?.bannerAd;

    final customPageViews = pageWiews.indexed.map(
      (pairValueElement) {
        if (pairValueElement.$1 == NavigationParameters.homeView) {
          return _GetPageView(banner: homeBannerAd, child: pairValueElement.$2);
        }
        if (pairValueElement.$1 == NavigationParameters.upcomingView) {
          return _GetPageView(
              banner: categoryBannerAd, child: pairValueElement.$2);
        }
        if (pairValueElement.$1 == NavigationParameters.favoriteView) {
          return _GetPageView(
              banner: favoriteBannerAd, child: pairValueElement.$2);
        }
        return const SizedBox();
      },
    ).toList();

    return Scaffold(
      body: IndexedStack(index: page, children: customPageViews),
      bottomNavigationBar: CustomNavigationBottom(page: page),
    );
  }
}

class _GetPageView extends StatelessWidget {
  final BannerAd? bannerAd;
  final Widget child;

  const _GetPageView({BannerAd? banner, required this.child})
      : bannerAd = banner;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: child),
        bannerAd == null
            ? const SizedBox()
            : CustomBannerAd(bannerAd: bannerAd!),
      ],
    );
  }
}
