import 'package:cinemapedia_app/domain/entities/video.dart';

abstract class VideoRepository {
  Future<List<Video>> loadVideos(String movieId);
}
