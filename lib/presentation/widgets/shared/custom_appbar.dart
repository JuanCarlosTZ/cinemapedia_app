import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final VoidCallback onPressed;
  const CustomAppbar({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Image.asset('assets/icon/app-icon-2.png', cacheHeight: 30),
            const SizedBox(width: 5),
            const Text('Cinemapedia TZ'),
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
