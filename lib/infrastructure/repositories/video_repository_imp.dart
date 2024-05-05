import 'package:cinemapedia_app/domain/datasources/videos_datasource.dart';
import 'package:cinemapedia_app/domain/entities/video.dart';
import 'package:cinemapedia_app/domain/repositories/video_repository.dart';

class VideoRepositoryImp extends VideoRepository {
  final VideoDatasource datasource;

  VideoRepositoryImp({required this.datasource});
  @override
  Future<List<Video>> loadVideos(String movieId) async {
    return datasource.loadVideos(movieId);
  }
}
