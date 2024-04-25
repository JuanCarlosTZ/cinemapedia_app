import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/widgets/movie/movie_description_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<int?> {
  final SearchMoviesCallback onSearch;
  final StreamController<List<Movie>> movieStream =
      StreamController.broadcast();

  final StreamController<bool> loadingStream = StreamController();

  SearchMovieDelegate({
    required this.onSearch,
  }) : super(
          searchFieldLabel: 'Buscar peliculas...',
        );

  Timer? _debounceTimer;

  void _onQueryChanged(String query) {
    loadingStream.add(true);
    if (_debounceTimer?.isActive == true) _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(seconds: 1), () async {
      final movies = await onSearch(query);
      movieStream.add(movies);
      loadingStream.add(false);
    });
  }

  @override
  void dispose() {
    movieStream.close();
    super.dispose();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder<bool>(
          stream: loadingStream.stream,
          builder: (context, snapshot) {
            //refreshing
            if (snapshot.data == true && query.isNotEmpty) {
              return SpinPerfect(
                infinite: true,
                child: IconButton(
                  icon: const Icon(Icons.refresh_outlined),
                  onPressed: () {},
                ),
              );
            }

            //cleanner
            return FadeInRight(
              animate: query.isNotEmpty,
              child: IconButton(
                onPressed: () {
                  query = '';
                },
                icon: const Icon(Icons.close),
              ),
            );
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        movieStream.close();
        context.pop();
      },
      icon: const Icon(Icons.arrow_back_ios_new_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _BouncedMovies(movieStream: movieStream);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return _BouncedMovies(movieStream: movieStream);
  }
}

class _BouncedMovies extends StatelessWidget {
  const _BouncedMovies({
    required this.movieStream,
  });

  final StreamController<List<Movie>> movieStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: movieStream.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data;
        if (movies == null) return const SizedBox();
        return SafeArea(
          top: false,
          bottom: false,
          child: FadeIn(
            child: ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      movieStream.close();
                      context.pop(movies[index].id);
                    },
                    child: MovieDescriptionView(
                      movie: movies[index],
                      isCompact: true,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
