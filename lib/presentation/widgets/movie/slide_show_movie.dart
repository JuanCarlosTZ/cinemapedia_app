import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/widgets/movie/custom_image_view.dart';
import 'package:flutter/material.dart';

class SlideShowMovie extends StatelessWidget {
  final List<Movie> movies;
  const SlideShowMovie(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final swiperPagination = SwiperPagination(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.bottomCenter,
      builder: DotSwiperPaginationBuilder(
          activeColor: colors.primary, color: colors.outlineVariant),
    );

    return SizedBox(
      width: double.infinity,
      height: 210,
      child: Swiper(
        loop: false,
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        pagination: swiperPagination,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return CustomImageView(
            topPadding: 5,
            bottomPadding: 30,
            movies[index].backdropPath,
          );
        },
      ),
    );
  }
}
