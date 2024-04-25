import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final VoidCallback onPressed;
  const CustomAppbar({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Icon(Icons.movie_rounded, color: colors.primary),
            const SizedBox(width: 5),
            const Text('Cinemapidia'),
            const Spacer(),
            IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.search),
            ),
          ],
        ),
      ),
    );
  }
}
