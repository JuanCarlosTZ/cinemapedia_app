import 'package:cinemapedia_app/domain/entities/video.dart';
import 'package:cinemapedia_app/infrastructure/models/video/tmb_video_response_model.dart';

class VideoMapper {
  static Video tmdbVideoModelToEntity(TmdbVideoModel videoModel) => Video(
        id: videoModel.id,
        name: videoModel.name,
        youtubeKey: videoModel.key,
        publichedAt: videoModel.publishedAt,
      );

  static List<Video> tmdbVideosModelToEntity(
      TmdbVideoResponseModel videosModel) {
    final videos = videosModel.results
        .map((videoModel) => tmdbVideoModelToEntity(videoModel))
        .toList();
    return videos;
  }
}
