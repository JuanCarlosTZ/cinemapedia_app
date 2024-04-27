import 'package:cinemapedia_app/config/constants/assets_images_app.dart';
import 'package:cinemapedia_app/config/router/app_router.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/screens.dart';
import 'package:cinemapedia_app/presentation/widgets/shared/custom_item_slide.dart';
import 'package:cinemapedia_app/presentation/widgets/shared/custom_rated_items.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HorizontalListviewMovie extends StatefulWidget {
  final String? title;
  final String? header;
  final List<Movie> movies;
  final VoidCallback? loadNextPage;
  const HorizontalListviewMovie({
    super.key,
    this.title,
    this.header,
    required this.movies,
    this.loadNextPage,
  });

  @override
  State<HorizontalListviewMovie> createState() =>
      _HorizontalListviewMovieState();
}

class _HorizontalListviewMovieState extends State<HorizontalListviewMovie> {
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
              itemCount: widget.movies.length,
              itemBuilder: (context, index) {
                final movie = widget.movies[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.goNamed(
                          MovieInfoScreen.name,
                          pathParameters: AppRouter.getMovieInfoParameters(
                              idPath: movie.id),
                        );
                      },
                      child: CustomItemSlide(
                        caption: movie.title,
                        urlImage: movie.posterPath == null
                            ? AssetsImagesApp.avatarPerson01
                            : movie.posterPath!,
                        isAssetImage: movie.posterPath == null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: CustomRatedItems(
                        voteAverage: movie.voteAverage,
                        voteCount: movie.voteCount,
                      ),
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
