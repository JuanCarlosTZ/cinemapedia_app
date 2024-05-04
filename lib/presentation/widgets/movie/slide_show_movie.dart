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
      margin: const EdgeInsets.symmetric(vertical: 0),
      alignment: Alignment.bottomCenter,
      builder: DotSwiperPaginationBuilder(
          activeColor: colors.primary, color: colors.outlineVariant),
    );

    final sizes = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: 210,
      child: Swiper(
        loop: false,
        viewportFraction: sizes.width > 1000 ? 0.4 : 0.8,
        scale: sizes.width > 1000 ? 0.6 : 0.9,
        autoplay: true,
        pagination: swiperPagination,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return CustomImageView(
            topPadding: 5,
            bottomPadding: 30,
            movies[index].backdropPath ?? '',
          );
        },
      ),
    );
  }
}
