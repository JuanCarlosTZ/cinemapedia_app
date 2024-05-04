import 'package:cinemapedia_app/domain/entities/movie.dart';

abstract class LocalStorageMoviesRepository {
  Future<List<Movie>> getFavorites({int limit = 10, int offset = 0});

  Future<bool> tougleFavorite({required Movie movie});

  Future<bool> isFavorite(int movieId);
}
