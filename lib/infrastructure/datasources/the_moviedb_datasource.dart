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
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final Response response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});

    final moviesPaginatedModel =
        TheMoviedbPagenatedModel.fromJson(response.data);

    final List<Movie> movies = moviesPaginatedModel.theMoviedbModelList
        .map((theMoviedbModel) =>
            MovieMapper.theMoviedbModelToEntity(theMoviedbModel))
        .toList();

    return movies;
  }
}
