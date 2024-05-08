import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef MovieCategoryCallback = Future<List<Movie>> Function(
    {int page, List<int> categoryIds});

class MoviesCategoryNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCategoryCallback fetchMoreMovies;
  bool isLoading = false;

  MoviesCategoryNotifier({required this.fetchMoreMovies}) : super([]);

  Future<List<Movie>> loadNextPage({List<int>? categoryIds}) async {
    if (isLoading || state.length >= 100) return state;

    if (categoryIds == null) {
      state = [];
      return state;
    }
    isLoading = true;
    currentPage++;

    final movies =
        await fetchMoreMovies(page: currentPage, categoryIds: categoryIds);
    state = [...state, ...movies];

    await Future.delayed(Durations.medium2);
    isLoading = false;
    return state;
  }

  Future<void> reset({List<int>? categoryIds}) async {
    currentPage = 0;
    state = [];
    await loadNextPage(categoryIds: categoryIds);
  }
}

final moviesCategoryProvider =
    StateNotifierProvider<MoviesCategoryNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(theMoviedbRepositoryProvider).getByCategory;
  return MoviesCategoryNotifier(
    fetchMoreMovies: fetchMoreMovies,
  );
});
