import 'package:cinemapedia_app/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavigationBottom extends StatelessWidget {
  final int page;
  const CustomNavigationBottom({super.key, required this.page});

  void onTapItem(BuildContext context, int page) {
    context.go('/${AppRouter.home}/$page');
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: page,
      onTap: (value) {
        onTapItem(context, value);
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
          label: 'Categoría',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.favorite),
          icon: Icon(Icons.favorite_outline),
          label: 'Favorito',
        ),
      ],
    );
  }
}
