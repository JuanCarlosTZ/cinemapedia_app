import 'package:cinemapedia_app/domain/datasources/local_storage_movies_datasource.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/domain/repositories/local_storage_movies_repository.dart';

class LocalStorageMoviesRepositoryImp extends LocalStorageMoviesRepository {
  final LocalStorageMoviesDatasource datasource;

  LocalStorageMoviesRepositoryImp({required this.datasource});

  @override
  Future<List<Movie>> getFavorites({int limit = 10, int offset = 0}) async {
    return await datasource.getFavorites(limit: limit, offset: offset);
  }

  @override
  Future<bool> tougleFavorite({required Movie movie}) async {
    return await datasource.tougleFavorite(movie);
  }

  @override
  Future<bool> isFavorite(int movieId) async {
    return await datasource.isFavorite(movieId);
  }
}
