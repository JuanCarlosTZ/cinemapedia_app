import 'package:cinemapedia_app/config/helper/helpers.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/widgets/movie/custom_image_view.dart';
import 'package:flutter/material.dart';

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
                return _Slide(movie: widget.movies[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final ratingColor = Colors.orange.shade900;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 210,
            width: 150,
            child: CustomImageView(movie.posterPath),
          ),
          const SizedBox(height: 10),
          Text(movie.title,
              style: textStyle.titleSmall, softWrap: true, maxLines: 2),
          Row(
            children: [
              Icon(Icons.star_half_rounded, color: ratingColor),
              Text(
                Helpers.humanNumber(movie.voteAverage),
                style: textStyle.bodyLarge?.copyWith(color: ratingColor),
              ),
              const SizedBox(width: 20),
              Text(
                Helpers.humanNumber(movie.voteCount.toDouble()),
                style: textStyle.bodyMedium,
              ),
            ],
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
