import 'package:cinemapedia_app/infrastructure/datasources/the_moviedb_datasource.dart';
import 'package:cinemapedia_app/infrastructure/repositories/movies_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final theMoviedbRepositoryProvider = Provider<MoviesRepositoryImpl>((ref) {
  final datasource = TheMoviedbDatasource();
  return MoviesRepositoryImpl(datasource);
});
