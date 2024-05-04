import 'package:cinemapedia_app/config/constants/assets_images_app.dart';
import 'package:cinemapedia_app/config/router/app_router.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/screens.dart';
import 'package:cinemapedia_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomPosterItemView extends StatelessWidget {
  const CustomPosterItemView({
    super.key,
    required this.movie,
    this.showRate = true,
    this.page = 0,
  });

  final Movie movie;
  final bool showRate;
  final int page;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            context.goNamed(
              MovieInfoScreen.name,
              pathParameters: AppRouter.getMovieInfoParameters(
                  idPath: movie.id, pageIndex: page),
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
        showRate
            ? Padding(
                padding: const EdgeInsets.only(left: 3),
                child: CustomRatedItems(
                  voteAverage: movie.voteAverage,
                  voteCount: movie.voteCount,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
