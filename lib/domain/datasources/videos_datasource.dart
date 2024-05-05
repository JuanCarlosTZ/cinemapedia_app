import 'package:cinemapedia_app/domain/entities/video.dart';

abstract class VideoDatasource {
  Future<List<Video>> loadVideos(String movieId);
}
