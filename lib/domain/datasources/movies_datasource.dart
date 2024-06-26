import 'package:cinemapedia_app/domain/entities/movie.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getNowPlaying({int page = 1});

  Future<List<Movie>> getPopular({int page = 1});

  Future<List<Movie>> getUpcoming({int page = 1});

  Future<List<Movie>> getTopRated({int page = 1});

  Future<Movie> getMovieById(String movieId);

  Future<List<Movie>> getSearch(String query);

  Future<List<Movie>> getRecommendation(String movieId);

  Future<List<Movie>> getByCategory({int page = 1, List<int>? categoryIds});
}
