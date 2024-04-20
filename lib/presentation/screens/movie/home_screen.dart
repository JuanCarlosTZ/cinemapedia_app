import 'package:cinemapedia_app/presentation/widgets/movie/horizontal_listview_movie.dart';
import 'package:cinemapedia_app/presentation/widgets/shared/custom_navigaton_bottom.dart';
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
      bottomNavigationBar: CustomNavigationBottom(),
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
    if (ref.read(popularMoviesProvider).isEmpty) {
      ref.read(popularMoviesProvider.notifier).loadNextPage();
    }
    if (ref.read(upcomingMoviesProvider).isEmpty) {
      ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    }
    if (ref.read(topRatedMoviesProvider).isEmpty) {
      ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mainShowMovies = ref.watch(swipeShowMoviesProvider);
    final topTenMovies = ref.watch(customPopularTopTenProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    final List<Widget> _sliverContent = [
      SlideShowMovie(mainShowMovies),
      const SizedBox(height: 20),
      HorizontalListviewMovie(
        title: "En cines",
        header: 'Lunes 20',
        movies: nowPlayingMovies,
        loadNextPage: () {
          ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
        },
      ),
      HorizontalListviewMovie(
        title: "Mejor votadas",
        movies: topRatedMovies,
        loadNextPage: () {
          ref.read(topRatedMoviesProvider.notifier).loadNextPage();
        },
      ),
      HorizontalListviewMovie(
        title: "Populares",
        header: 'Top 10',
        movies: topTenMovies,
      ),
      HorizontalListviewMovie(
        title: "Muy pronto",
        header: 'Solo en cines',
        movies: upcomingMovies,
        loadNextPage: () {
          ref.read(upcomingMoviesProvider.notifier).loadNextPage();
        },
      )
    ];

    return CustomScrollView(
      slivers: [
        const SliverAppBar(floating: true, flexibleSpace: CustomAppbar()),
        SliverList(
          delegate: SliverChildBuilderDelegate(
              childCount: _sliverContent.length,
              (context, index) => _sliverContent[index]),
        ),
      ],
    );
  }
}
