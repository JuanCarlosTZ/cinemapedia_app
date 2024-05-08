import 'package:cinemapedia_app/presentation/views/home/favorite_view.dart';
import 'package:flutter/material.dart';

import 'package:cinemapedia_app/presentation/widgets/shared/custom_navigaton_bottom.dart';
import 'package:cinemapedia_app/presentation/views/home/home_view.dart';
import 'package:cinemapedia_app/presentation/views/home/category_view.dart';

class HomeScreen extends StatelessWidget {
  static String name = 'home_screen';
  final int page;
  const HomeScreen({super.key, required this.page});

  final List<Widget> pageWiews = const [
    HomeView(),
    CategoryView(),
    FavoriteView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: page, children: pageWiews),
      bottomNavigationBar: CustomNavigationBottom(page: page),
    );
  }
}
