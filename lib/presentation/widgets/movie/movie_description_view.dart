import 'package:cinemapedia_app/config/constants/assets_images_app.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/widgets/movie/custom_image_view.dart';
import 'package:cinemapedia_app/presentation/widgets/shared/custom_rated_items.dart';
import 'package:flutter/material.dart';

class MovieDescriptionView extends StatelessWidget {
  final Movie movie;
  final bool isCompact;
  const MovieDescriptionView({
    super.key,
    required this.movie,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.of(context).size;
    final style = Theme.of(context).textTheme;
    final double maxWidth = isCompact ? 500.0 : 1000.0;
    final double width = (sizes.width > maxWidth) ? maxWidth : sizes.width;
    final double shortWidth = 0.25 * width;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //* imagen
        SizedBox(
          width: shortWidth - 20,
          height: (shortWidth - 20) * 1.5,
          child: CustomImageView(
            movie.posterPath ?? AssetsImagesApp.noPoster01,
            isAssetImage: movie.posterPath == null,
          ),
        ),
        const SizedBox(width: 10),

        //* Texto

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //* Titulo
              Text(
                movie.title ?? '',
                style: isCompact ? style.titleMedium : style.titleLarge,
                softWrap: true,
                maxLines: isCompact ? 3 : null,
              ),
              const SizedBox(height: 5),

              //* Resumen

              isCompact
                  ? Text(
                      movie.overview ?? '',
                      softWrap: true,
                      maxLines: 3,
                      style: style.bodyMedium?.copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : Text(
                      movie.overview ?? '',
                      style: style.bodyLarge,
                      softWrap: true,
                    ),

              CustomRatedItems(
                voteAverage: movie.voteAverage,
                voteCount: movie.voteCount,
              )
            ],
          ),
        )
      ],
    );
  }
}
