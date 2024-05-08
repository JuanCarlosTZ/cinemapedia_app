import 'package:cinemapedia_app/config/constants/environment.dart';
import 'package:cinemapedia_app/domain/datasources/genre_datasource.dart';
import 'package:cinemapedia_app/domain/entities/genre.dart';
import 'package:cinemapedia_app/infrastructure/mappers/genre_mapper.dart';
import 'package:cinemapedia_app/infrastructure/models/movie/tmdb_gender_model.dart';
import 'package:dio/dio.dart';

class TmdbGenresDatasource extends GenreDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: Environment.datasourceConfiguration.baseUrl,
      queryParameters: {
        'api_key': Environment.datasourceConfiguration.apiKey,
        'language': 'es-MX'
      }));

  Future<List<Genre>> _getList(String url) async {
    final response = await dio.get(url);
    final genres = GenreMapper.tmdbGenresResponseToEntity(
        TmdbGenreResponseModel.fromJson(response.data));
    return genres;
  }

  @override
  Future<List<Genre>> getGenres() async {
    return await _getList('/genre/movie/list');
  }
}
