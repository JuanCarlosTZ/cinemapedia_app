import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:cinemapedia_app/config/constants/navigation_parameters.dart';
import 'package:cinemapedia_app/presentation/providers/movie/local_movies_provider.dart';
import 'package:cinemapedia_app/presentation/widgets/movie/custom_poster_item_view.dart';

class FavoriteView extends ConsumerStatefulWidget {
  const FavoriteView({super.key});

  @override
  FavoriteViewState createState() => FavoriteViewState();
}

class FavoriteViewState extends ConsumerState<FavoriteView> {
  late final ScrollController controller;
  @override
  void initState() {
    super.initState();
    if (ref.read(localMoviesProvider).isEmpty) {
      ref.read(localMoviesProvider.notifier).loadNextPage();
    }

    controller = ScrollController();
    controller.addListener(() {
      final movies = ref.read(localMoviesProvider);
      if (movies.isEmpty) {
        return;
      }
      if (controller.position.pixels + 200 >
          controller.position.maxScrollExtent) {
        ref.read(localMoviesProvider.notifier).loadNextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final moviesProvider = ref.watch(localMoviesProvider);
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
              page: NavigationParameters.favoriteView,
            ),
          );
        },
      ),
    );
  }
}
