import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/widgets/movie/movie_description_view.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<int?> {
  final SearchMoviesCallback onSearch;
  final StreamController<List<Movie>> movieStream =
      StreamController.broadcast();

  final StreamController<bool> loadingStream = StreamController();
  List<Movie> initialData;

  SearchMovieDelegate({
    required this.initialData,
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

      initialData = movies;
      movieStream.add(movies);
      loadingStream.add(false);
    });
  }

  void closeStream() {
    movieStream.close();
  }

  @override
  void dispose() {
    closeStream();
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
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _BouncedMovies(
      initialData: initialData,
      movieStream: movieStream,
      onPressed: (int id) {
        closeStream();
        close(context, id);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return _BouncedMovies(
      initialData: initialData,
      movieStream: movieStream,
      onPressed: (int id) {
        closeStream();
        close(context, id);
      },
    );
  }
}

class _BouncedMovies extends StatelessWidget {
  final StreamController<List<Movie>> movieStream;
  final List<Movie> initialData;
  final Function(int id) onPressed;

  const _BouncedMovies({
    required this.movieStream,
    required this.initialData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Movie>>(
      initialData: initialData,
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
                    onTap: () => onPressed(movies[index].id),
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
