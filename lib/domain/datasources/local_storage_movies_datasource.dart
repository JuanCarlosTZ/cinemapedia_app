import 'package:cinemapedia_app/domain/entities/movie.dart';

abstract class LocalStorageMoviesDatasource {
  Future<List<Movie>> getFavorites({int limit = 10, int offset = 0});

  Future<bool> tougleFavorite(Movie movie);

  Future<bool> isFavorite(int movieId);
}
