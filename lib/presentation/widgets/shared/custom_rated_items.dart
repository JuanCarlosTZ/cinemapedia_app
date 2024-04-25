import 'package:cinemapedia_app/config/helper/helpers.dart';
import 'package:flutter/material.dart';

class CustomRatedItems extends StatelessWidget {
  final double voteAverage;
  final int voteCount;
  const CustomRatedItems({
    super.key,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final ratingColor = Colors.orange.shade900;
    return Row(
      children: [
        Icon(Icons.star_half_rounded, color: ratingColor),
        Text(
          Helpers.humanNumber(voteAverage),
          style: textStyle.bodyLarge?.copyWith(color: ratingColor),
        ),
        const SizedBox(width: 20),
        Text(
          Helpers.humanNumber(voteCount.toDouble()),
          style: textStyle.bodyMedium,
        ),
      ],
    );
  }
}
