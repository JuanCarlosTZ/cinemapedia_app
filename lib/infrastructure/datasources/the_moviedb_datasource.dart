import 'package:cinemapedia_app/config/constants/environment.dart';
import 'package:cinemapedia_app/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia_app/infrastructure/models/movie/the_moviedb_paginated_model.dart';
import 'package:dio/dio.dart';

class TheMoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.datasourceConfiguration.baseUrl,
    queryParameters: <String, dynamic>{
      'language': 'es-MX',
      'api_key': Environment.datasourceConfiguration.apiKey,
    },
  ));

  @override
  Future<List<Movie>> get(
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

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    return await get('/movie/now_playing', queryParameters: {'page': page});
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    return await get('/movie/popular', queryParameters: {'page': page});
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    return await get('/movie/top_rated', queryParameters: {'page': page});
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    return await get('/movie/upcoming', queryParameters: {'page': page});
  }
}
