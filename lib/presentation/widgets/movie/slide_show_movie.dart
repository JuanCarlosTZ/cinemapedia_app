import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
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
          return _Slide(movies[index]);
        },
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide(this.movie);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final decoration =
        BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
      BoxShadow(
          color: colors.secondary.withOpacity(0.8),
          blurRadius: 10,
          offset: const Offset(0, 10)),
    ]);

    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 10),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(movie.backdropPath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
