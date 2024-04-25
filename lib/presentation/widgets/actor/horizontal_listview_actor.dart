import 'package:cinemapedia_app/config/constants/assets_images_app.dart';
import 'package:cinemapedia_app/domain/entities/actor.dart';
import 'package:cinemapedia_app/presentation/widgets/shared/custom_item_slide.dart';
import 'package:flutter/material.dart';

class HorizontalListviewActor extends StatefulWidget {
  final String? title;
  final String? header;
  final List<Actor> actors;
  final VoidCallback? loadNextPage;
  const HorizontalListviewActor({
    super.key,
    this.title,
    this.header,
    required this.actors,
    this.loadNextPage,
  });

  @override
  State<HorizontalListviewActor> createState() =>
      _HorizontalListviewActorState();
}

class _HorizontalListviewActorState extends State<HorizontalListviewActor> {
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
            height: 300,
            width: double.infinity,
            child: ListView.builder(
              controller: controller,
              itemExtent: 150,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              scrollDirection: Axis.horizontal,
              itemCount: widget.actors.length,
              itemBuilder: (context, index) {
                final actor = widget.actors[index];

                return Column(
                  children: [
                    CustomItemSlide(
                      caption: '${actor.name} - ${actor.character}',
                      urlImage: actor.profilePath.isEmpty
                          ? AssetsImagesApp.avatarPerson01
                          : actor.profilePath,
                      isAssetImage: actor.profilePath.isEmpty,
                    ),
                  ],
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
  const _HeaderBar({
    this.header,
    this.title,
  });

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
