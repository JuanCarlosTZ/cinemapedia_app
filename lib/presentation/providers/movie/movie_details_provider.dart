import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef MovieDetailsCallback = Future<Movie> Function(String movieId);

class MoviesDetailNotifier extends StateNotifier<Map<String, Movie>> {
  final MovieDetailsCallback getMovie;

  MoviesDetailNotifier({
    required this.getMovie,
  }) : super({});

  Future<void> loadMovieById(String movieId) async {
    if (state[movieId] != null) return;
    print('movieId: $movieId');
    final movie = await getMovie(movieId);

    state = {...state, movieId: movie};
  }
}

final movieDetailProvider =
    StateNotifierProvider<MoviesDetailNotifier, Map<String, Movie>>((ref) {
  final getMovieById = ref.watch(theMoviedbRepositoryProvider).getMovieById;

  return MoviesDetailNotifier(getMovie: getMovieById);
});
