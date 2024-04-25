import 'package:cinemapedia_app/presentation/widgets/movie/custom_image_view.dart';
import 'package:flutter/material.dart';

class CustomItemSlide extends StatelessWidget {
  final String urlImage;
  final String caption;
  final bool isAssetImage;
  const CustomItemSlide({
    super.key,
    required this.urlImage,
    required this.caption,
    this.isAssetImage = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: 210,
              width: 150,
              child: CustomImageView(
                urlImage,
                isAssetImage: isAssetImage,
              )),
          const SizedBox(height: 10),
          Text(caption,
              style: textStyle.titleSmall
                  ?.copyWith(overflow: TextOverflow.ellipsis),
              softWrap: true,
              maxLines: 2),
        ],
      ),
    );
  }
}
