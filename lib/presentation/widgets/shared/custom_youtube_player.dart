import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomYoutubePlayer extends StatefulWidget {
  final String youtubeKey;
  final String name;

  const CustomYoutubePlayer({
    super.key,
    required this.youtubeKey,
    required this.name,
  });

  @override
  State<CustomYoutubePlayer> createState() => _CustomYoutubePlayerState();
}

class _CustomYoutubePlayerState extends State<CustomYoutubePlayer> {
  late final YoutubePlayerController controller;
  @override
  void initState() {
    super.initState();

    controller = YoutubePlayerController(
        initialVideoId: widget.youtubeKey,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: YoutubePlayer(controller: controller),
    );
  }
}
