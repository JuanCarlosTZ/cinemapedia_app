import 'package:cinemapedia_app/config/constants/enums_app.dart';
import 'package:cinemapedia_app/config/constants/environment.dart';
import 'package:cinemapedia_app/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia_app/infrastructure/models/movie/the_moviedb_paginated_model.dart';
import 'package:cinemapedia_app/infrastructure/models/movie/tmdb_movie_details_model.dart';
import 'package:dio/dio.dart';

class TheMoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.datasourceConfiguration.baseUrl,
    queryParameters: <String, dynamic>{
      QueryParameter.language: 'es-MX',
      QueryParameter.apiKey: Environment.datasourceConfiguration.apiKey,
    },
  ));

  Future<List<Movie>> _getList(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final Response response =
        await dio.get(url, queryParameters: queryParameters);

    final List<Movie> movies = MovieMapper.theMoviedbPaginatedToListEntity(
      TheMoviedbPagenatedModel.fromJson(response.data),
    );

    return movies;
  }

  Future<Movie> _get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final Response response =
        await dio.get(url, queryParameters: queryParameters);

    final Movie movie = MovieMapper.tmdbMovieDetailsModelToEntity(
      TmdbMovieDetailsModel.fromJson(response.data),
    );

    return movie;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    return await _getList('/movie/now_playing',
        queryParameters: {QueryParameter.page: page});
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    return await _getList('/movie/popular',
        queryParameters: {QueryParameter.page: page});
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    return await _getList('/movie/top_rated',
        queryParameters: {QueryParameter.page: page});
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    return await _getList('/movie/upcoming',
        queryParameters: {QueryParameter.page: page});
  }

  @override
  Future<Movie> getMovieById(String movieId) async {
    final movie = await _get('/movie/$movieId');
    return movie;
  }

  @override
  Future<List<Movie>> getSearch(String query) async {
    final movies = await _getList('/search/movie',
        queryParameters: {QueryParameter.query: query});
    return movies;
  }
}
