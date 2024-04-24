import 'package:cinemapedia_app/config/constants/assets_images_app.dart';
import 'package:cinemapedia_app/presentation/widgets/movie/custom_image_view.dart';
import 'package:flutter/material.dart';

class CustomItemSlide extends StatelessWidget {
  final String urlImage;
  final String caption;
  final String? placeholderAssetImage;
  const CustomItemSlide({
    super.key,
    required this.urlImage,
    required this.caption,
    this.placeholderAssetImage,
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
            child: urlImage.isNotEmpty
                ? CustomImageView(urlImage)
                : CustomImageView(
                    AssetsImagesApp.avatarPerson01,
                    isAssetImage: true,
                  ),
          ),
          const SizedBox(height: 10),
          Text(caption,
              style: textStyle.titleSmall, softWrap: true, maxLines: 2),
        ],
      ),
    );
  }
}
