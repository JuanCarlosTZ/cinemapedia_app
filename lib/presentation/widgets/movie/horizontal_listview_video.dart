import 'package:cinemapedia_app/domain/entities/video.dart';
import 'package:cinemapedia_app/presentation/widgets/shared/custom_youtube_player.dart';
import 'package:flutter/material.dart';

class HorizontalListviewVideo extends StatefulWidget {
  final String? title;
  final String? header;
  final List<Video> videos;
  final VoidCallback? loadNextPage;
  const HorizontalListviewVideo({
    super.key,
    this.title,
    this.header,
    required this.videos,
    this.loadNextPage,
  });

  @override
  State<HorizontalListviewVideo> createState() =>
      _HorizontalListviewVideoState();
}

class _HorizontalListviewVideoState extends State<HorizontalListviewVideo> {
  late final ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    controller.addListener(() {
      if (widget.loadNextPage == null) return;
      if (controller.position.pixels + 200 >
          controller.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          _HeaderBar(title: widget.title, header: widget.header),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: ListView.builder(
              controller: controller,
              itemExtent: 400,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              scrollDirection: Axis.horizontal,
              itemCount: widget.videos.length,
              itemBuilder: (context, index) {
                final video = widget.videos[index];
                return CustomYoutubePlayer(
                  youtubeKey: video.youtubeKey,
                  name: video.name,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderBar extends StatelessWidget {
  final String? title;
  final String? header;
  const _HeaderBar({this.title, this.header});

  @override
  Widget build(BuildContext context) {
    if (title == null && header == null) return const SizedBox();

    final textStyle = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final decoration = BoxDecoration(
      color: colors.secondaryContainer,
      borderRadius: BorderRadius.circular(20),
    );

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Text('$title', style: textStyle.titleLarge),
          const Spacer(),
          header == null
              ? const SizedBox()
              : DecoratedBox(
                  decoration: decoration,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 25),
                    child: Text(
                      '$header',
                      style: textStyle.titleSmall,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
