import 'package:cinemapedia_app/domain/entities/genre.dart';
import 'package:cinemapedia_app/presentation/providers/category/categoty_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesProvider = Provider((ref) async {
  final repository = ref.watch(tmdbCategoryRepositoryProvider);
  final categories = await repository.getGenres();

  return categories;
});

final categoryControllerProvider = Provider((ref) {
  return ExpansionTileController();
});

final categoryProvider = StateProvider<Genre?>((ref) {
  return null;
});
