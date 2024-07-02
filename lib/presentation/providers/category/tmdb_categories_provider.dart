import 'package:cinemapedia_app/domain/entities/genre.dart';
import 'package:cinemapedia_app/domain/repositories/genre_repository.dart';
import 'package:cinemapedia_app/presentation/providers/category/categoty_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesProvider =
    StateNotifierProvider<CategoryNotifier, CategoryState>((ref) {
  final repository = ref.watch(tmdbCategoryRepositoryProvider);
  return CategoryNotifier(repository: repository);
});

final categoryControllerProvider = Provider((ref) {
  return ExpansionTileController();
});

final categoryProvider = StateProvider<Genre?>((ref) {
  return null;
});

class CategoryNotifier extends StateNotifier<CategoryState> {
  final GenreRepository repository;

  CategoryNotifier({required this.repository})
      : super(CategoryState(
          categories: [],
          isLoading: false,
        )) {
    loadCatagory();
  }

  Future<CategoryState> loadCatagory() async {
    if (state.isLoading) return state;
    try {
      state = state.copyWith(isLoading: true);
      final categories = await repository.getGenres();

      await Future.delayed(Durations.medium2);
      state = state.copyWith(
        categories: categories,
        isLoading: false,
      );

      return state;
    } catch (ex) {
      state = state.copyWith(isLoading: false);
      return state;
    }
  }
}

class CategoryState {
  final List<Genre> categories;
  final bool isLoading;

  CategoryState({required this.categories, required this.isLoading});

  CategoryState copyWith({
    List<Genre>? categories,
    bool? isLoading,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
