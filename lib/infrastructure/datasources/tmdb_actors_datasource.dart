import 'package:cinemapedia_app/config/constants/environment.dart';
import 'package:cinemapedia_app/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia_app/domain/entities/actor.dart';
import 'package:cinemapedia_app/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia_app/infrastructure/models/actor/tmdb_actors_response_model.dart';
import 'package:dio/dio.dart';

class TmdbActorsDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: Environment.datasourceConfiguration.baseUrl,
      queryParameters: {
        'api_key': Environment.datasourceConfiguration.apiKey,
        'language': 'es-MX'
      }));

  Future<List<Actor>> _getList(
    String url, {
    Map<String, String>? queryParameters,
  }) async {
    final response = await dio.get(url, queryParameters: queryParameters);
    final actors = ActorMapper.tmdbActorsResponseToEntity(
        TmdbActorsResponseModel.fromJson(response.data));
    return actors;
  }

  @override
  Future<List<Actor>> getActors({required String movieId}) async {
    return await _getList('/movie/$movieId/credits');
  }
}
