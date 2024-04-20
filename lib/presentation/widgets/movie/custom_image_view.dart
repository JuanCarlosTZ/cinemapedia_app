import 'package:flutter/material.dart';

class CustomImageView extends StatelessWidget {
  const CustomImageView(this.url,
      {super.key, this.topPadding = 0, this.bottomPadding = 0});

  final String url;
  final double topPadding;
  final double bottomPadding;

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
      padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(url, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
