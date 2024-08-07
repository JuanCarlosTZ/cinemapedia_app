import 'package:cinemapedia_app/config/router/app_router.dart';
import 'package:cinemapedia_app/infrastructure/services/app_initialize_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia_app/presentation/widgets/widgets.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:cinemapedia_app/presentation/delegates/search_movie_delegate.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  bool isSplashAvailable = true;
  @override
  void initState() {
    super.initState();
    if (ref.read(nowPlayingMoviesProvider).isEmpty) {
      ref.read(nowPlayingMoviesProvider.notifier).loadFirstPage();
    }
    if (ref.read(popularMoviesProvider).isEmpty) {
      ref.read(popularMoviesProvider.notifier).loadFirstPage();
    }
    if (ref.read(upcomingMoviesProvider).isEmpty) {
      ref.read(upcomingMoviesProvider.notifier).loadFirstPage();
    }
    if (ref.read(topRatedMoviesProvider).isEmpty) {
      ref.read(topRatedMoviesProvider.notifier).loadFirstPage();
    }
  }

  void _validateFirstLoaded(List<List<Object?>> states) {
    if (!isSplashAvailable) return;
    if (states.contains([])) return;

    isSplashAvailable = false;
    AppInitializeService.removeFlutterNativeSplash();
  }

  Future<void> _restartLoad() async {
    await ref.read(nowPlayingMoviesProvider.notifier).loadFirstPage();
    await ref.read(popularMoviesProvider.notifier).loadFirstPage();
    await ref.read(upcomingMoviesProvider.notifier).loadFirstPage();
    await ref.read(topRatedMoviesProvider.notifier).loadFirstPage();
  }

  @override
  Widget build(BuildContext context) {
    final mainShowMovies = ref.watch(swipeShowMoviesProvider);
    final topTenMovies = ref.watch(customPopularTopTenProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final searchMovies = ref.watch(searchMoviesProvider);

    _validateFirstLoaded([
      mainShowMovies,
      topTenMovies,
      nowPlayingMovies,
      topRatedMovies,
      upcomingMovies,
    ]);

    final List<Widget> sliverContent = [
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
        movies: upcomingMovies,
        loadNextPage: () {
          ref.read(upcomingMoviesProvider.notifier).loadNextPage();
        },
      ),
    ];

    return RefreshIndicator(
      onRefresh: _restartLoad,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
              floating: true,
              flexibleSpace: CustomAppbar(onPressed: () {
                final query = searchMovies.entries.last.key;
                final movies = searchMovies.entries.last.value;

                showSearch(
                    query: query,
                    context: context,
                    delegate: SearchMovieDelegate(
                      initialData: movies,
                      onSearch: (String query) {
                        return ref
                            .read(searchMoviesProvider.notifier)
                            .loadSearchMovies(query);
                      },
                    )).then((value) {
                  if (value != null) {
                    context.push(
                      AppRouter.getMovieInfoPath(movieId: value.toString()),
                    );
                  }
                });
              })),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: sliverContent.length,
                (context, index) => sliverContent[index]),
          ),
        ],
      ),
    );
  }
}
