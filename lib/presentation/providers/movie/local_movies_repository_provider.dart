import 'package:cinemapedia_app/infrastructure/datasources/local_movies_datasource.dart';
import 'package:cinemapedia_app/infrastructure/repositories/local_storage_movies_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localMoviesRepositoryProvider = Provider((ref) {
  final repository =
      LocalStorageMoviesRepositoryImp(datasource: LocalMoviesDatasource());

  return repository;
});
