import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia_app/config/router/app_router.dart';

class CustomNavigationBottom extends StatefulWidget {
  const CustomNavigationBottom({super.key});
  @override
  State<CustomNavigationBottom> createState() => _CustomNavigationBottomState();
}

class _CustomNavigationBottomState extends State<CustomNavigationBottom> {
  int indexSelected = 0;

  void onItemTab(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(RouteLocationApp.home);
      case 1:
        break;
      case 2:
        context.go(RouteLocationApp.favorites);
    }
  }

  int getTabIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;

    if (location == RouteLocationApp.home) return 0;
    if (location == RouteLocationApp.categories) return 1;
    if (location == RouteLocationApp.favorites) return 2;

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: getTabIndex(context),
      onTap: (value) {
        onItemTab(context, value);
      },
      items: const [
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.label),
          icon: Icon(Icons.label_outline),
          label: 'Categorias',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.favorite),
          icon: Icon(Icons.favorite_outline),
          label: 'Favoritos',
        ),
      ],
    );
  }
}
