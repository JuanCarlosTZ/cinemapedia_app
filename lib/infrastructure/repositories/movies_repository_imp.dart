import 'package:cinemapedia_app/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl extends MoviesRepository {
  final MoviesDatasource datasource;

  MoviesRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    return await datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    return await datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    return await datasource.getUpcoming(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    return await datasource.getTopRated(page: page);
  }

  @override
  Future<Movie> getMovieById(String movieId) async {
    return await datasource.getMovieById(movieId);
  }

  @override
  Future<List<Movie>> getSearch(String query) async {
    return await datasource.getSearch(query);
  }

  @override
  Future<List<Movie>> getRecommendation(String movieId) async {
    return await datasource.getRecommendation(movieId);
  }
}
