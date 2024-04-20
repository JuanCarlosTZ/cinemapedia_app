import 'package:cinemapedia_app/presentation/widgets/movie/horizontal_listview_movie.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:cinemapedia_app/presentation/widgets/movie/slide_show_movie.dart';
import 'package:cinemapedia_app/presentation/widgets/shared/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  static String name = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    if (ref.read(nowPlayingMoviesProvider).isEmpty) {
      ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(swipeShowMoviesProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    return Column(
      children: [
        const CustomAppbar(),
        SlideShowMovie(movies),
        HorizontalListviewMovie(
          title: "En cines",
          header: 'Lunes 20',
          movies: nowPlayingMovies,
          loadNextPage: () {
            ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
          },
        )
      ],
    );
  }
}
