import 'package:cinemapedia_app/config/constants/environment.dart';
import 'package:cinemapedia_app/domain/datasources/videos_datasource.dart';
import 'package:cinemapedia_app/domain/entities/video.dart';
import 'package:cinemapedia_app/infrastructure/mappers/video_mapper.dart';
import 'package:cinemapedia_app/infrastructure/models/video/tmb_video_response_model.dart';
import 'package:dio/dio.dart';

class TmdbVideoDatasource extends VideoDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: Environment.datasourceConfiguration.baseUrl,
      queryParameters: {
        'api_key': Environment.datasourceConfiguration.apiKey,
        'language': 'es-MX'
      }));

  Future<List<Video>> _getList(
    String url, {
    Map<String, String>? queryParameters,
  }) async {
    final response = await dio.get(url, queryParameters: queryParameters);
    final videos = VideoMapper.tmdbVideosModelToEntity(
        TmdbVideoResponseModel.fromJson(response.data));
    return videos;
  }

  @override
  Future<List<Video>> loadVideos(String movieId) async {
    return await _getList('/movie/$movieId/videos');
  }
}
