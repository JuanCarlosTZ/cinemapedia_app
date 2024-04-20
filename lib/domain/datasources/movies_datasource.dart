import 'package:cinemapedia_app/domain/entities/movie.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> get(String url, {Map<String, dynamic>? queryParameters});
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getUpcoming({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});
}
