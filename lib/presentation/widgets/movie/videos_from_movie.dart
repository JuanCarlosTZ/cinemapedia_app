import 'package:cinemapedia_app/domain/entities/video.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosFromMovie extends StatelessWidget {
  final List<Video> traillers;
  const VideosFromMovie({super.key, required this.traillers});

  @override
  Widget build(BuildContext context) {
    if (traillers.isEmpty) return const SizedBox();
    final video = traillers.first;
    return _YoutubePlayer(
      youtubeId: video.id,
      name: video.name,
    );
  }
}

class _YoutubePlayer extends StatefulWidget {
  final String youtubeId;
  final String name;

  const _YoutubePlayer({
    required this.youtubeId,
    required this.name,
  });

  @override
  State<_YoutubePlayer> createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<_YoutubePlayer> {
  late final YoutubePlayerController controller;
  @override
  void initState() {
    super.initState();

    controller = YoutubePlayerController(
        initialVideoId: widget.youtubeId,
        flags: const YoutubePlayerFlags(
          hideThumbnail: true,
          showLiveFullscreenButton: false,
          mute: false,
          autoPlay: false,
          disableDragSeek: true,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: false,
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(controller: controller);
  }
}
