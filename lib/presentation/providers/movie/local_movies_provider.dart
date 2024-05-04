import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/movie/local_movies_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef LocalMoviesCallback = Future<List<Movie>> Function(
    {int limit, int offset});
typedef TougleFavoriteCallback = Future<bool> Function({required Movie movie});

class LocalMovies extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  final limit = 10;

  bool isLoading = false;

  final LocalMoviesCallback loadMoviesCallback;
  LocalMovies({required this.loadMoviesCallback}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading || state.length < currentPage * limit) return;

    isLoading = true;
    final movies =
        await loadMoviesCallback(limit: limit, offset: currentPage * limit);
    state = [...state, ...movies];

    currentPage++;
    isLoading = false;

    return;
  }

  Future<void> resetPage() async {
    currentPage = 0;
    state = [];
    Future.delayed(Durations.medium2);
    await loadNextPage();
    return;
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
