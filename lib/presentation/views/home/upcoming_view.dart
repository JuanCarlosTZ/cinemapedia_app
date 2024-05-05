import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:cinemapedia_app/config/constants/navigation_parameters.dart';
import 'package:cinemapedia_app/presentation/widgets/movie/custom_poster_item_view.dart';

class UpcomingView extends ConsumerStatefulWidget {
  const UpcomingView({super.key});

  @override
  FavoriteViewState createState() => FavoriteViewState();
}

class FavoriteViewState extends ConsumerState<UpcomingView> {
  late final ScrollController controller;
  @override
  void initState() {
    super.initState();
    if (ref.read(localMoviesProvider).isEmpty) {
      ref.read(popularMoviesProvider.notifier).loadNextPage();
    }

    controller = ScrollController();
    controller.addListener(() {
      final movies = ref.read(upcomingMoviesProvider);
      if (movies.isEmpty) {
        return;
      }
      if (controller.position.pixels + 200 >
          controller.position.maxScrollExtent) {
        ref.read(upcomingMoviesProvider.notifier).loadNextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final moviesProvider = ref.watch(upcomingMoviesProvider);

    return Scaffold(
      body: MasonryGridView.count(
        controller: controller,
        itemCount: moviesProvider.length,
        crossAxisCount: 3,
        itemBuilder: (context, index) {
          final movie = moviesProvider[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: CustomPosterItemView(
              movie: movie,
              page: NavigationParameters.upcomingView,
            ),
          );
        },
      ),
    );
  }
}
