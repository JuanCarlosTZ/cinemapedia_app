import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/movie/local_movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef LocalMoviesCallback = Future<List<Movie>> Function(
    {int limit, int offset});
typedef TougleFavoriteCallback = Future<bool> Function({required Movie movie});

class LocalMovies extends StateNotifier<List<Movie>> {
  final LocalMoviesCallback loadMoviesCallback;
  LocalMovies({required this.loadMoviesCallback}) : super([]);

  Future<List<Movie>> loadMovies({int limit = 10, int offoset = 0}) async {
    final movies = await loadMoviesCallback(limit: 10, offset: offoset);

    state = [...state, ...movies];
    return movies;
  }
}

class TougleFavorite extends StateNotifier<bool> {
  final TougleFavoriteCallback tougleFavoriteCallback;
  TougleFavorite({required this.tougleFavoriteCallback}) : super(false);

  Future<bool> tougleFavorite({required Movie movie}) async {
    final isFavorite = await tougleFavoriteCallback(movie: movie);

    state = isFavorite;
    return isFavorite;
  }
}

final localMoviesProvider =
    StateNotifierProvider<LocalMovies, List<Movie>>((ref) {
  final callback = ref.watch(localMoviesRepositoryProvider).getFavorites;
  return LocalMovies(loadMoviesCallback: callback);
});

final tougleFavoriteProvider =
    StateProvider.autoDispose.family((ref, Movie movie) async {
  final isFavorite = await ref
      .watch(localMoviesRepositoryProvider)
      .tougleFavorite(movie: movie);

  return isFavorite;
});

final isFavoriteProvider =
    StateProvider.autoDispose.family((ref, int movieId) async {
  final isFavorite =
      await ref.watch(localMoviesRepositoryProvider).isFavorite(movieId);

  return isFavorite;
});
